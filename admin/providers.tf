terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.3.0"
    }
    talos = {
      source = "siderolabs/talos"
      version = "0.7.1"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = false
    pm_api_url = var.proxmox_api_url
    pm_password = var.proxmox_password
    pm_user = var.proxmox_username
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}