################################################################################
# VPC
################################################################################
variable "vpc_name" {
  type  = string
  default = "VPC_Task"
}

variable "vpc_version" {
  type  = string
  default = "5.1.1"
}

variable "vpc_cidr" {
  type  = string
  default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  type  = list
  default = ["10.0.128.0/19"]
}

variable "vpc_public_subnets" {
  type  = list
  default = ["10.0.0.0/19","10.0.32.0/19","10.0.64.0/19"]
}