#!/bin/bash
tofu apply

rm -rf ~/.kube
rm -rf ~/.talos

talosctl config merge configs/talosconfig 
talosctl -n ctrl.k8s.srv6.dk kubeconfig

helm repo add cilium https://helm.cilium.io/

sleep 15

helm install cilium cilium/cilium --namespace kube-system -f cilium-values.yaml


sleep 15


./annotate-nodes.sh