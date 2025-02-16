# Notes

## Useful commands
### K8S port forward to global address
In this example bind the capacitor service in the flux-system namespace to [::] for global ipv6 access
```bash
kubectl -n flux-system port-forward svc/capacitor 9000:9000 --address="::"
```