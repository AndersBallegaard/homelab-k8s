resource "proxmox_vm_qemu" "worker_vmhost_a" {
  count = var.k8s_worker_node_a
  vmid        = "621${count.index}"
  name        = "worker-a-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_a
  agent       = 1
  cores       = var.k8s_worker_cpu_count
  memory      = var.k8s_worker_mem_mb
  boot        = "order=scsi0" 
  clone       = "ubuntu24-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  cicustom   = "vendor=nas_v6:snippets/ubuntu24-cloud-init-snippet.yml"
  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1:: 1.1.1.1"
  ipconfig0  = "ip=10.25.1.11${count.index}/24,gw=10.25.1.1,ip6=2a0e:97c0:ae2:2501::a1c${count.index}/64,gw6=2a0e:97c0:ae2:2501::1"
  skip_ipv6  = false
  ciuser     = var.vm_user_username
  sshkeys    = var.vm_user_sshkey
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "nas_v6"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = "10G" 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "nas_v6"
        }
      }
    }
  }

  network {
    id = 0
    bridge = "VL2501"
    model  = "virtio"
  }
}
resource "proxmox_vm_qemu" "worker_vmhost_b" {
  count = var.k8s_worker_node_b
  vmid        = "622${count.index}"
  name        = "worker-b-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_b
  agent       = 1
  cores       = var.k8s_worker_cpu_count
  memory      = var.k8s_worker_mem_mb
  boot        = "order=scsi0" 
  clone       = "ubuntu24-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  cicustom   = "vendor=nas_v6:snippets/ubuntu24-cloud-init-snippet.yml"
  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1:: 1.1.1.1"
  ipconfig0  = "ip=10.25.1.12${count.index}/24,gw=10.25.1.1,ip6=2a0e:97c0:ae2:2501::b1c${count.index}/64,gw6=2a0e:97c0:ae2:2501::1"
  skip_ipv6  = false
  ciuser     = var.vm_user_username
  sshkeys    = var.vm_user_sshkey
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "nas_v6"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = "10G" 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "nas_v6"
        }
      }
    }
  }

  network {
    id = 0
    bridge = "VL2501"
    model  = "virtio"
  }
}
resource "proxmox_vm_qemu" "worker_vmhost_c" {
  count = var.k8s_worker_node_c
  vmid        = "623${count.index}"
  name        = "worker-c-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_a
  agent       = 1
  cores       = var.k8s_worker_cpu_count
  memory      = var.k8s_worker_mem_mb
  boot        = "order=scsi0" 
  clone       = "ubuntu24-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  cicustom   = "vendor=nas_v6:snippets/ubuntu24-cloud-init-snippet.yml"
  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1:: 1.1.1.1"
  ipconfig0  = "ip=10.25.1.13${count.index}/24,gw=10.25.1.1,ip6=2a0e:97c0:ae2:2501::c1c${count.index}/64,gw6=2a0e:97c0:ae2:2501::1"
  skip_ipv6  = false
  ciuser     = var.vm_user_username
  sshkeys    = var.vm_user_sshkey
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "nas_v6"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = "10G" 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "nas_v6"
        }
      }
    }
  }

  network {
    id = 0
    bridge = "VL2501"
    model  = "virtio"
  }
}