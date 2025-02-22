#!/bin/bash
k8s_version=$(kubectl version -o json | jq .serverVersion.gitVersion | sed 's/\"//g')
prod_name=srv6-homelab
timestamp=$(date -I)
results_name="$prod_name--$k8s_version@$timestamp"

mkdir -p ./${results_name}/

go install sigs.k8s.io/hydrophone@latest

~/go/bin/hydrophone --conformance --output-dir ./${results_name}/

echo "Remember to commit these results, please specify if it was done as part of an upgrade, cluster rebuild, or improvement"