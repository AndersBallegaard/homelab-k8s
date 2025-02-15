resource "ansible_host" "ctrl_a" {
    count = var.k8s_ctrl_node_a
    name = "ctrl-a-${count.index}.${var.vm_dns_suffix}"
    groups = ["k8s_ctrl"]
    variables = {
        ansible_user = var.vm_user_username
    }
}
resource "ansible_host" "ctrl_b" {
    count = var.k8s_ctrl_node_b
    name = "ctrl-b-${count.index}.${var.vm_dns_suffix}"
    groups = ["k8s_ctrl"]
    variables = {
        ansible_user = var.vm_user_username
    }
}
resource "ansible_host" "worker_a" {
    count = var.k8s_worker_node_a
    name = "worker-a-${count.index}.${var.vm_dns_suffix}"
    groups = ["k8s_worker"]
    variables = {
        ansible_user = var.vm_user_username
    }
}
resource "ansible_host" "worker_b" {
    count = var.k8s_worker_node_b
    name = "worker-b-${count.index}.${var.vm_dns_suffix}"
    groups = ["k8s_worker"]
    variables = {
        ansible_user = var.vm_user_username
    }
}
resource "ansible_host" "worker_c" {
    count = var.k8s_worker_node_c
    name = "worker-c-${count.index}.${var.vm_dns_suffix}"
    groups = ["k8s_worker"]
    variables = {
        ansible_user = var.vm_user_username
    }
}
