resource "proxmox_vm_qemu" "ctrl_vmhost_a" {
  count = var.k8s_ctrl_node_a
  vmid        = "511${count.index}"
  name        = "ctrl-a-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_a
  agent       = 1
  cores       = var.k8s_ctrl_cpu_count
  memory      = var.k8s_ctrl_mem_mb
  boot        = "order=scsi0;ide2" 
  clone       = "talos-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true
  onboot = true

  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1::"
  ipconfig0  = "ip6=${var.proxmox_ipv6_net}::a0c${count.index}/64,gw6=${var.proxmox_ipv6_net}::1"
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
          storage = "${var.proxmox_vm_storage}"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = var.k8s_vm_diskspace 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "${var.proxmox_vm_storage}"
        }
      }
      ide2 {
        cdrom {
          iso = "${var.proxmox_iso_storage}:iso/talos-nocloud-amd64.iso"
        }
      }
    }
  }

  network {
    id = 0
    bridge = var.proxmox_nic
    model  = "virtio"
  }
}
resource "proxmox_vm_qemu" "ctrl_vmhost_b" {
  count = var.k8s_ctrl_node_b
  vmid        = "512${count.index}"
  name        = "ctrl-b-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_b
  agent       = 1
  cores       = var.k8s_ctrl_cpu_count
  memory      = var.k8s_ctrl_mem_mb
  boot        = "order=scsi0;ide2" 
  clone       = "talos-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true
  onboot = true

  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1::"
  ipconfig0  = "ip6=${var.proxmox_ipv6_net}::b0c${count.index}/64,gw6=${var.proxmox_ipv6_net}::1"
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
          storage = "${var.proxmox_vm_storage}"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = var.k8s_vm_diskspace 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "${var.proxmox_vm_storage}"
        }
      }
      ide2 {
        cdrom {
          iso = "${var.proxmox_iso_storage}:iso/talos-nocloud-amd64.iso"
        }
      }
    }
  }

  network {
    id = 0
    bridge = var.proxmox_nic
    model  = "virtio"
  }
}
resource "proxmox_vm_qemu" "ctrl_vmhost_c" {
  count = var.k8s_ctrl_node_c
  vmid        = "513${count.index}"
  name        = "ctrl-c-${count.index}.${var.vm_dns_suffix}"
  target_node = var.proxmox_target_node_c
  agent       = 1
  cores       = var.k8s_ctrl_cpu_count
  memory      = var.k8s_ctrl_mem_mb
  boot        = "order=scsi0;ide2" 
  clone       = "talos-template"
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  ciupgrade  = true
  nameserver = "2a0e:97c0:ae1::"
  ipconfig0  = "ip6=${var.proxmox_ipv6_net}::c0c${count.index}/64,gw6=${var.proxmox_ipv6_net}::1"
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
          storage = "${var.proxmox_vm_storage}"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = var.k8s_vm_diskspace 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "${var.proxmox_vm_storage}"
        }
      }
      ide2 {
        cdrom {
          iso = "${var.proxmox_iso_storage}:iso/talos-nocloud-amd64.iso"
        }
      }
    }
  }

  network {
    id = 0
    bridge = var.proxmox_nic
    model  = "virtio"
  }
}
