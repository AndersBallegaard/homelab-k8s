resource "cloudflare_dns_record" "ctrl_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_a
  proxied = false
  name = "ctrl-a-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::a0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_b
  proxied = false
  name = "ctrl-b-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::b0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_c_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_c
  proxied = false
  name = "ctrl-c-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::c0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_a
  proxied = false
  name = "worker-a-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::a1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "worker-b-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::b1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_c_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_c
  proxied = false
  name = "worker-c-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::c1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_vip_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_a
  proxied = false
  name = "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::a0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_vip_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_b
  proxied = false
  name = "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::b0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_vip_c_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_c
  proxied = false
  name = "${var.talos_cluster_endpoint_prefix}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::c0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_a" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_a
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::a1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_b" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::b1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_c" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "${var.proxmox_ipv6_net}::c1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_ext_vip" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = true
  name = "ext-vip.${var.vm_dns_suffix}"
  type = "CNAME"
  content = "vip.${var.vm_dns_suffix}"
  ttl = 1
}
resource "cloudflare_dns_record" "map_cluster_domain_to_workers" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = true
  name = "${var.vm_dns_suffix}"
  type = "CNAME"
  content = "vip.${var.vm_dns_suffix}"
  ttl = 1
}

