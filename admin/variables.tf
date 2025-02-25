variable "proxmox_api_url" {
    type = string
    default = "" # Should look something like https://proxmox01.example.com:8006/api2/json
}
variable "proxmox_username" {
    type = string
    default = "" # Should look something root@pam
}
variable "proxmox_password" {
    type = string
    default = "" # Should look something badpassword123
}
variable "proxmox_target_node_a" {
    type = string
    default = "heimdall"
}
variable "proxmox_target_node_b" {
    type = string
    default = "thor"
}
variable "proxmox_target_node_c" {
    type = string
    default = "thor" # Intentional due to the nodes avalible, should be changed when a 3rd proxmox node is added
}
variable "proxmox_nic" {
  type = string
  default = "VL2502"
}
variable "proxmox_ipv6_net" {
  type = string
  default = "2a0e:97c0:ae3:fff0" # Expects network part of /64
}
variable "proxmox_vm_storage" {
  type = string
  default = "local"
}
variable "proxmox_iso_storage" {
  type = string
  default = "nas_v6"
}
variable "proxmox_data_storage" {
  type = string
  default = "nas_v6"
}
variable "vm_user_username" {
    type = string
    default = "" # Should look something 'user'
}
variable "vm_user_sshkey" {
    type = string
    default = "" 
}
variable "k8s_ctrl_node_a" {
    type = number
    default = 1
}
variable "k8s_ctrl_node_b" {
    type = number
    default = 1
}
variable "k8s_ctrl_node_c" {
    type = number
    default = 1
}
variable "k8s_worker_node_a" {
    type = number
    default = 1
}
variable "k8s_worker_node_b" {
    type = number
    default = 1
}
variable "k8s_worker_node_c" {
    type = number
    default = 2
}
variable "k8s_ctrl_cpu_count" {
    type = number
    default = 2
}
variable "k8s_ctrl_mem_mb" {
    type = number
    default = 3072
}

variable "k8s_worker_cpu_count" {
    type = number
    default = 4
}
variable "k8s_worker_mem_mb" {
    type = number
    default = 10240
}
variable "vm_dns_suffix" {
  type = string
  default = "k8s.srv6.dk"
}
variable "cloudflare_api_token" {
  type = string
  default = ""
}
variable "cloudflare_zone_id" {
  type = string
  default = "" # Should be zoneid matching vm_dns_suffix
}
variable "talos_cluster_name" {
  type = string
  default = "homelab"
}
variable "talos_cluster_endpoint_prefix" {
  type = string
  default = "ctrl"
}