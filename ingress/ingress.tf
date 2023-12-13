resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = "${var.ingress_name}"
  }
}

module "nginx_ingress" {
  source  = "terraform-module/release/helm"
  version = "2.7.0"

  namespace  = kubernetes_namespace.nginx_ingress.metadata.0.name
  repository = "${var.ingress_repo}"
  app = {
    name          = "ingress-nginx"
    version       = "4.1.0"
    chart         = "ingress-nginx"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  set = [
    {
      name  = "replicaCount"
      value = 2
    }
  ]
}
