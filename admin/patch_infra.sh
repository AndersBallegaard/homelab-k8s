#!/bin/bash
tofu apply

rm -rf ~/.kube
rm -rf ~/.talos

talosctl config merge configs/talosconfig 
talosctl -n ctrl.k8s.srv6.dk kubeconfig
