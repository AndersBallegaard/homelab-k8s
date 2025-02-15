# Lab admin
This directory contains scripts and configuration related to lab administration

## Prepare admin node
To convert an ubuntu machine to an admin node run this command.
This script uses git over SSH, so make sure the admin node have ssh keys created, and those keys have been added to github

The script does the following
- Installs openTofu
- Installs git
- Downloads this repository
```bash
curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/AndersBallegaard/homelab-k8s/refs/heads/main/admin/prepare_admin_node.sh | bash
```

## Prepare proxmox for cloudinit
In case proxmox isn't ready for cloudinit of ubuntu 24.04, this is how to set it up. All these commands should be run from a proxmox node
```bash
cd /tmp
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
qm create 9024 --name ubuntu24-template
# We use local storage right now, because it doesn't seem to like templating a VM using network storage
qm set 9024 --scsi0 local:0,import-from=/tmp/noble-server-cloudimg-amd64.img
qm template 9024
# Move storage to network for node independant deployment
# /usr/bin/chattr +i will probably fail if using synology nas as shared storage, in the words of a proxmox emploee on the forum "while this is not optimal, it should not affect operation in any way (as long as no one messes with this file)"
qm move_disk 9024 scsi0 nas_v6
```

## Provision k3s VM's
```bash
# Set constant variables
./configure_variables.sh
source ~/.bashrc

# Set proxmox authentication variables
export proxmox_username=root@pam # Replace with correct user
export proxmox_password=bad_password123 # Replace with correct password

# Set cloud init credentials
export vm_user_username=anders 
export vm_user_sshkey="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHoVbRHKFBt8xP5Khw6T1togRM2oo6VRx+URB2iQ83+ anders@jumphost"

```