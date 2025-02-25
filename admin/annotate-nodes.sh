#!/bin/bash
kubectl annotate node ctrl-a-0 cilium.io/bgp-virtual-router.65500="router-id=100.126.1.0"
kubectl annotate node ctrl-b-0 cilium.io/bgp-virtual-router.65500="router-id=100.126.2.0"
kubectl annotate node ctrl-c-0 cilium.io/bgp-virtual-router.65500="router-id=100.126.3.0"


kubectl annotate node worker-a-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.1.0"
kubectl annotate node worker-b-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.2.0"
kubectl annotate node worker-c-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.3.0"
kubectl annotate node worker-a-1 cilium.io/bgp-virtual-router.65500="router-id=100.127.1.1"
kubectl annotate node worker-b-1 cilium.io/bgp-virtual-router.65500="router-id=100.127.2.1"
kubectl annotate node worker-c-1 cilium.io/bgp-virtual-router.65500="router-id=100.127.3.1"
