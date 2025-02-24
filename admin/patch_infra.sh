#!/bin/bash
tofu apply

rm -rf ~/.kube
rm -rf ~/.talos

talosctl config merge configs/talosconfig 
talosctl -n ctrl.k8s.srv6.dk kubeconfig

helm repo add cilium https://helm.cilium.io/
helm repo add rook-release https://charts.rook.io/release

sleep 15

helm install cilium cilium/cilium --namespace kube-system -f cilium-values.yaml

helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph
kubectl label namespace rook-ceph pod-security.kubernetes.io/enforce=privileged

sleep 15
helm install --create-namespace --namespace rook-ceph rook-ceph-cluster --set operatorNamespace=rook-ceph rook-release/rook-ceph-cluster


./annotate-nodes.sh