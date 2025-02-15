# All these variables are defaulting to "" because they should be set in your .bashrc using the configure_variables.sh script
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
variable "vm_user_username" {
    type = string
    default = "" # Should look something root@pam
}
variable "vm_user_sshkey" {
    type = string
    default = "" # Should look something badpassword123
}
