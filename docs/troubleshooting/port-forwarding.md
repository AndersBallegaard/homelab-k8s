# Port forwarding
For troubleshooting purposes it is often practical to port forward a service in k8s.

This is also the only way to access certine admin interfaces that aren't exposed with an ingress

## Generic service
This is the general way to expose any service with a port-forward.
In a step to reduce the use of legacy IP, binding to ipv6 is forced in this example, note you might want to bind to ::1 instead of ::
```bash
kubectl -n NAMESPACE port-forward svc/SERVICE_NAME PORT:PORT --address="::"
```

## Capacitor
If troubleshooting fluxcd, it might be nice to have a more visual representation of what services are in fluxcd.

For this purpose a capacitor deployment exists, but isn't exposed via any ingress for security reasons, to forward it run the following command
```bash
kubectl -n flux-system port-forward svc/capacitor 9000:9000 --address="::1"
```

## CEPH dashboard
When troubleshooting ceph/rook, it might be nice to use the ceph dashboard, it can be exposed using the following command
```bash
kubectl -n rook-ceph port-forward svc/rook-ceph-mgr-dashboard 7000:7000 --address="::"
```
In order to login use the username "admin", and the password provided by the following command.
```bash
kubectl get secret -n rook-ceph -o jsonpath='{.data.password}' rook-ceph-dashboard-password | base64 -d
```