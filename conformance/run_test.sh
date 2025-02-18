#!/bin/bash
k8s_version=$(kubectl version -o json | jq .serverVersion.gitVersion)
prod_name=srv6-homelab

go install github.com/vmware-tanzu/sonobuoy@latest

~/go/bin/sonobuoy run --mode=certified-conformance --wait
outfile=$(~/go/bin/sonobuoy retrieve)
mkdir ./results; tar xzf $outfile -C ./results
rm -rf ${k8s_version}
mkdir -p ./${k8s_version}/${prod_name}
cp ./results/plugins/e2e/results/global/* ./${k8s_version}/${prod_name}/

echo "Remember to commit these results, please specify if it was done as part of an upgrade, cluster rebuild, or improvement"