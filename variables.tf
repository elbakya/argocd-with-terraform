################################################################################
# Common
################################################################################

variable "helm_release" {
  type = string
  default = "3.36.0"
}

variable "env" {
  type = string
  default = "staging"
}

variable "eks_cert_auth_data" {
  type = string
  default = "None"
}

variable "main_cluster_name" {
  type = string
  default = "None"
}