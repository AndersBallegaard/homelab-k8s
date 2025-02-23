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
helm repo add cilium https://helm.cilium.io/

helm install cilium cilium/cilium --namespace kube-system -f cilium-values.yaml

```

## Setup rook
```bash
helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph
kubectl label namespace rook-ceph pod-security.kubernetes.io/enforce=privileged

helm install --create-namespace --namespace rook-ceph rook-ceph-cluster --set operatorNamespace=rook-ceph rook-release/rook-ceph-cluster

# NOTE: FluxCD will also deploy some Rook config, setting up rook/ceph will take forever, give it atleast 30 minutes before panicing
```

## Install metalLB
```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
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