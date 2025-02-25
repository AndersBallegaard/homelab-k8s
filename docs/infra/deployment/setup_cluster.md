## Provision Cluster
```bash
# Set env variables
export TF_VAR_cloudflare_api_token=READ_WRITE_TOKEN
export TF_VAR_cloudflare_zone_id=DOMAIN_ZONEID
export TF_VAR_vm_user_username=anders
export TF_VAR_vm_user_sshkey="SSH PUBLIC ID for authentication"
export TF_VAR_proxmox_username=USERNAME@pam
export TF_VAR_proxmox_password=PROXMOX_PASSWORD
export TF_VAR_proxmox_api_url=https://PROXMOX_SERVER:8006/api2/json


# Initialize openTofu
cd admin
tofu init

# Bootstrap the cluster
./patch_infra.sh 
```


## Setup Cillium CNI
```bash
# Create BGP Password
kubectl create secret generic -n kube-system --type=string bgp-auth-secret --from-literal=password=REPLACEWITHPASSWORD

```

## Setup fluxCD
```bash
flux bootstrap github \
  --token-auth \
  --owner=andersballegaard \
  --repository=homelab-k8s \
  --branch=main \
  --path=cluster \
  --personal
```