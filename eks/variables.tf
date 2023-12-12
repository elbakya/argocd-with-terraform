
################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-cluster"
}

variable "vpc_id_for_eks" {
  description = "Name of the EKS cluster"
  type        = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  description = "Name of the EKS cluster"
  type        = list
  default = ["10.0.10.0/24"]
}

variable "sg_id" {
  description = "Name of the EKS cluster"
  type        = string
  default = "None"
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster security group will be provisioned"
  type        = string
  default     = null
}
