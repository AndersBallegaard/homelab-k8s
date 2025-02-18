resource "talos_machine_secrets" "this" {}

locals {
  masters = tolist(concat(flatten(proxmox_vm_qemu.ctrl_vmhost_a[*].name), flatten(proxmox_vm_qemu.ctrl_vmhost_b[*].name), flatten(proxmox_vm_qemu.ctrl_vmhost_c[*].name)))
  workers = tolist(concat(flatten(proxmox_vm_qemu.worker_vmhost_a[*].name), flatten(proxmox_vm_qemu.worker_vmhost_b[*].name), flatten(proxmox_vm_qemu.worker_vmhost_c[*].name)))
}

data "talos_client_configuration" "this" {
  depends_on = [ proxmox_vm_qemu.ctrl_vmhost_a, proxmox_vm_qemu.ctrl_vmhost_b, proxmox_vm_qemu.ctrl_vmhost_c, proxmox_vm_qemu.worker_vmhost_a, proxmox_vm_qemu.worker_vmhost_b, proxmox_vm_qemu.worker_vmhost_c ]
  cluster_name = var.talos_cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes = concat(local.masters, local.workers)
  endpoints = [ "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}" ]
}

data "talos_machine_configuration" "masters" {
  depends_on = [ data.talos_client_configuration.this ]
  cluster_name = var.talos_cluster_name
  machine_type = "controlplane"
  cluster_endpoint = "https://${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}:6443"
  machine_secrets = talos_machine_secrets.this.machine_secrets
  config_patches = [
    file("${path.root}/talos_config/cluster.yml"),
  ]
}

data "talos_machine_configuration" "workers" {
  depends_on = [ data.talos_client_configuration.this ]
  cluster_name = var.talos_cluster_name
  machine_type = "worker"
  cluster_endpoint = "https://${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}:6443"
  machine_secrets = talos_machine_secrets.this.machine_secrets
  config_patches = [
    file("${path.root}/talos_config/cluster.yml"),
  ]
}

resource "talos_machine_configuration_apply" "masters" {
  depends_on = [ data.talos_machine_configuration.masters ]
  for_each = toset(local.masters)
  client_configuration = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.masters.machine_configuration
  node = each.key
}

resource "talos_machine_configuration_apply" "workers" {
  depends_on = [ data.talos_machine_configuration.workers ]
  for_each = toset(local.workers)
  client_configuration = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.workers.machine_configuration
  node = each.key
}
resource "time_sleep" "wait_until_reboot" {
  depends_on = [
    talos_machine_configuration_apply.masters,
    talos_machine_configuration_apply.workers
  ]
  create_duration = "5m"
}

resource "talos_machine_bootstrap" "this" {
  depends_on = [
    time_sleep.wait_until_reboot
  ]
  node = "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}"
  client_configuration = talos_machine_secrets.this.client_configuration
}
resource "talos_cluster_kubeconfig" "this" {
  depends_on = [ talos_machine_bootstrap.this ]
  client_configuration = talos_machine_secrets.this.client_configuration
  node = "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}"
}

resource "time_sleep" "wait_until_bootstrap" {
  depends_on = [
    local_file.kubeconfig,
    local_file.talosconfig
  ]
  create_duration = "5m"
}
resource "local_file" "talosconfig" {
    depends_on = [ talos_cluster_kubeconfig.this ]
    content = data.talos_client_configuration.this.talos_config
    filename = "configs/talosconfig"
}

resource "local_file" "kubeconfig" {
    depends_on = [ talos_cluster_kubeconfig.this ]
    content = talos_cluster_kubeconfig.this.kubeconfig_raw
    filename = "configs/kubeconfig"
}

resource "local_file" "worker_config" {
    depends_on = [ data.talos_machine_configuration.workers ]
    content = data.talos_machine_configuration.workers.machine_configuration
    filename = "configs/worker.yaml"
}

resource "local_file" "master_config" {
    depends_on = [ data.talos_machine_configuration.masters ]
    content = data.talos_machine_configuration.masters.machine_configuration
    filename = "configs/controlplane.yaml"
}