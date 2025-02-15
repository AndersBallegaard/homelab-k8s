#!/bin/bash
echo "Wellcome to the srv6.dk admin node preperation script"
echo "This script will automaticly prepare this system to act as an admin node for the homelab"
echo "This script expects a node based on ubuntu, but similar distros may also work"

# Check that we have root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with sudo"
  exit
fi

BASEDIR=$(pwd)

sudo apt install git
cd /tmp
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
sudo chmod +x install-opentofu.sh
./install-opentofu.sh --install-method deb
rm -f install-opentofu.sh


echo $BASEDIR

git clone git@github.com:AndersBallegaard/homelab-k8s.git
