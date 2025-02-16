#!/bin/bash
echo "Wellcome to the srv6.dk admin node preperation script"
echo "This script will automaticly prepare this system to act as an admin node for the homelab"
echo "This script expects a node based on ubuntu, but similar distros may also work"

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install -y git ansible
git clone git@github.com:AndersBallegaard/homelab-k8s.git

cd /tmp
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
sudo chmod +x install-opentofu.sh
./install-opentofu.sh --install-method deb
rm -f install-opentofu.sh



# Install ansible terraform plugin for dynamic inventory
ansible-galaxy collection install cloud.terraform
# Fix some lacking support for opentofu
sudo ln -s /usr/bin/tofu /usr/bin/terraform

# Install talosctl
curl -sL https://talos.dev/install | sh
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl