resource "helm_release" "argocd" {
  name  = "${var.argo_name}"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "${var.argo_namespace}"
  version          = "4.9.7"
  create_namespace = true
}


resource "helm_release" "argocd-app" {
  name  = "${var.argo_app_name}"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "${var.argo_namespace}"
  version          = "1.4.1"
  create_namespace = true

  values = [
    file("./argocd/application.yaml")
  ]
}

resource "null_resource" "connect_eks" {
    triggers = {
    order = helm_release.argocd.id
  }
  provisioner "local-exec" {
    command     = "aws eks --region eu-central-1 update-kubeconfig --name ${var.argo_cluster_name}"
  }
}

resource "null_resource" "password" {
  triggers = {
    order = null_resource.connect_eks.id
  }
  provisioner "local-exec" {
    working_dir = "./argocd"
    command     = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
  }
}

resource "null_resource" "del-argo-pass" {
  triggers = {
    order = null_resource.password.id
  }
  provisioner "local-exec" {
    command = "kubectl -n argocd delete secret argocd-initial-admin-secret"
  }
}
