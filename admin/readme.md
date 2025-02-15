# Lab admin
This directory contains scripts and configuration related to lab administration

## Prepare admin node
To convert an ubuntu machine to an admin node run this command
```bash
curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/AndersBallegaard/homelab-k8s/refs/heads/main/admin/prepare_admin_node.sh | bash
```