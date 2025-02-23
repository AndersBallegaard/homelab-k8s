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
