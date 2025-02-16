resource "cloudflare_dns_record" "ctrl_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_a
  proxied = false
  name = "ctrl-a-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::a0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_b
  proxied = false
  name = "ctrl-b-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::b0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_a
  proxied = false
  name = "worker-a-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::a1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "worker-b-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::b1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "worker_c_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_c
  proxied = false
  name = "worker-c-${count.index}.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::c1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_vip_a_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_a
  proxied = false
  name = "ctrl.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::a0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "ctrl_vip_b_dns" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_ctrl_node_b
  proxied = false
  name = "ctrl.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::b0c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_a" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_a
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::a1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_b" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::b1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_vip_c" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = false
  name = "vip.${var.vm_dns_suffix}"
  type = "AAAA"
  content = "2a0e:97c0:ae2:2501::c1c${count.index}"
  ttl = 300
}
resource "cloudflare_dns_record" "svc_ext_vip" {
  zone_id = var.cloudflare_zone_id
  count = var.k8s_worker_node_b
  proxied = true
  name = "ext-vip.${var.vm_dns_suffix}"
  type = "CNAME"
  content = "vip.${var.vm_dns_suffix}"
  ttl = 1
}
