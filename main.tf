
module "vpc" {
  source = "./vpc"
  vpc_name = "MyVPC"
  vpc_cidr = "10.0.0.0/16"
  vpc_public_subnets = ["10.0.0.0/19","10.0.32.0/19","10.0.64.0/19"]
  vpc_private_subnets = ["10.0.128.0/19"]
}
