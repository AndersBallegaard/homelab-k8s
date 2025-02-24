#!/bin/bash
kubectl annotate node worker-a-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.1.0"
kubectl annotate node worker-b-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.2.0"
kubectl annotate node worker-c-0 cilium.io/bgp-virtual-router.65500="router-id=100.127.3.0"
