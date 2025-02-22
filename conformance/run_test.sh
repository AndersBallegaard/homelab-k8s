#!/bin/bash
k8s_version=$(kubectl version -o json | jq .serverVersion.gitVersion | sed 's/\"//g')
prod_name=srv6-homelab
mkdir -p ./${k8s_version}/

go install sigs.k8s.io/hydrophone@latest

~/go/bin/hydrophone --conformance --output-dir ./${k8s_version}/

echo "Remember to commit these results, please specify if it was done as part of an upgrade, cluster rebuild, or improvement"