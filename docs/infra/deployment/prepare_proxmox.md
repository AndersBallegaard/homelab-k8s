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
