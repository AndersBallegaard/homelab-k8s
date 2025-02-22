# Notes

## Useful commands
### K8S port forward to global address
In this example bind the capacitor service in the flux-system namespace to [::] for global ipv6 access
```bash
kubectl -n flux-system port-forward svc/capacitor 9000:9000 --address="::"
```


## Commonly used forwarding commands
```bash
kubectl -n flux-system port-forward svc/capacitor 9000:9000 --address="::"
kubectl -n rook-ceph port-forward svc/rook-ceph-mgr-dashboard 7000:7000 --address="::"
# Get secret for ceph admin with "kubectl get secret -n rook-ceph -o jsonpath='{.data.password}' rook-ceph-dashboard-password | base64 -d"
```