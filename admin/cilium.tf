data "helm_template" "cilium_template" {
  name = "cilium"
  namespace = "kube-system"
  repository = "https://helm.cilium.io/"

  chart = "cilium"
  version = "1.15.3"

  include_crds = true
}
resource "local_file" "cilium_config" {
    depends_on = [ data.helm_template.cilium_template ]
    content = templatefile("${path.root}/patches/cilium-cni-template.yaml", {cilium_yaml = data.helm_template.cilium_template.manifest})
    filename = "talos_config/cilium-cni-patch.yaml"
}