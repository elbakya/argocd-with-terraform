variable "ingress_name" {
  type = string
  default = "ingress-nginx"
}
variable "ingress_repo" {
  type = string
  default = "https://kubernetes.github.io/ingress-nginx"
}