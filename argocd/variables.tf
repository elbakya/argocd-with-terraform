variable "argo_name" {
  type = string
  default = "argocd"
}

variable "argo_app_name" {
  type = string
  default = "argocd-app"
}

variable "argo_namespace" {
  type = string
  default = "argocd"
}

variable "argo_cluster_name" {
  type = string
  default = "my-cluster"
}