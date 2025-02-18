# Issues
This file exists to document problems with achiving perfect conformety
---
## Template issue
### Detailed description
### Notes
### Affected tests


## Tests fails due to wrong domain
### Detailed description
Testing assumes cluster domain is cluster.local, this means all tests that try accessing resources inside the cluster by FQDN will fail.
### Notes
- Seems like Sonobuoy use the build in e2e or conformaty test suit for k8s (See https://github.com/kubernetes/kubernetes/tree/master/test)
- test/e2e/framework/test_context.go seems to have a clusterDNSDomain option
- However Casandra tests seems to have a hardcoded domain name of cluster.local
- Seems like 
### Affected tests
- A lot
