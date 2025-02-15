#!/bin/bash
# Sets constant variables not related to authentication
# only prompts for vars not currently set

if [ -z "$proxmox_api_url" ]
then
    read -p "Please provide a valid proxmox hostname for api usage like proxmox.example.com: " URL
    echo "export TF_VAR_proxmox_api_url=https://$URL:8006/api2/json" >> ~/.bashrc
fi