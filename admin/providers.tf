terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = false
    pm_api_url = vars.proxmox_api_url
    pm_password = vars.proxmox_password
    pm_user = vars.proxmox_username
}