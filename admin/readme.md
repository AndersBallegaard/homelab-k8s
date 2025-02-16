# Lab admin
This directory contains scripts and configuration related to lab administration

## Prepare admin node
To convert an ubuntu machine to an admin node run this command.
This script uses git over SSH, so make sure the admin node have ssh keys created, and those keys have been added to github

The script does the following
- Installs openTofu
- Installs git
- Downloads this repository
- Installs talosctl
- Installs kubectl
- Installs helm
- Installs flux
```bash
curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/AndersBallegaard/homelab-k8s/refs/heads/main/admin/prepare_admin_node.sh | bash
```

## Prepare proxmox for cloudinit
In case proxmox isn't ready for cloudinit of talos, this is how to set it up. Currently this is done from the proxmox UI as a one of thing
```bash
# Download a talos image from the talos image factory, it needs to be a nocloud image
# The image should be placed under the name "talos-nocloud-amd64.iso" in the shared vm datastore

# Create a VM with the 1g disk on shared storage, and attach the iso. Ram and CPU doesn't matter
# Don't start the VM
# The vm MUST be named talos-template, and should have the ID 9100
# CPU Type should be host for best performace
# Disk size is intentionally below recormendations for faster template deployments, cloud init will resize to whatever the VM is speced for
#
# Convert VM to template

```

## Provision Cluster
```bash
# Set constant variables
./configure_variables.sh
source ~/.bashrc

# Set proxmox authentication variables
export TF_VAR_proxmox_username=root@pam # Replace with correct user
export TF_VAR_proxmox_password=bad_password123 # Replace with correct password

# Set cloud init credentials
export TF_VAR_vm_user_username=anders 
export TF_VAR_vm_user_sshkey="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHoVbRHKFBt8xP5Khw6T1togRM2oo6VRx+URB2iQ83+ anders@jumphost"

# Set cloudflare credentials, needs privileges to edit the DNS zone in vm_dns_suffix
export TF_VAR_cloudflare_api_token=fakekey

# Download snippet
cd /mnt/pve/nas_v6/snippets/
wget https://raw.githubusercontent.com/AndersBallegaard/homelab-k8s/refs/heads/main/admin/resources/ubuntu24-cloud-init-snippet.yml

cd admin
tofu init

# View planned changes
tofu plan

# Provision machines
tofu apply
```

## Setup Talos
```bash
# Clean any previous config
rm -rf ~/.kube
rm -rf ~/.talos

talosctl config merge configs/talosconfig 
talosctl -n ctrl.k8s.srv6.dk kubeconfig
```

## Setup fluxCD
```bash
flux bootstrap github \
  --token-auth \
  --owner=andersballegaard \
  --repository=homelab-k8s \
  --branch=main \
  --path=cluster \
  --cluster-domain k8s.srv6.dk \
  --personal
```