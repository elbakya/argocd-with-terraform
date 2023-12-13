
module "vpc" {
  source = "./vpc"
  vpc_name = "MyVPC"
  vpc_cidr = "10.0.0.0/16"
  vpc_public_subnets = ["10.0.0.0/19","10.0.32.0/19","10.0.64.0/19"]
  vpc_private_subnets = ["10.0.128.0/19"]
}

module "eks" {
  source = "./eks"
  vpc_id_for_eks = module.vpc.vpc_id
  vpc_public_subnets = module.vpc.public_subnets
  sg_id = module.sg.security_groups
  #depends_on = [ module.vpc ]
}

module "sg" {
  source = "./sg"
  sg_vpc_id = module.vpc.vpc_id
  sg_cluster_name = module.eks.eks_cluster_name
  sg_public_subnets = module.vpc.public_subnets
  sg_private_subnets = module.vpc.private_subnets
  #depends_on = [ module.eks ]
}

module "ingress" {
  source = "./ingress"
  ingress_name = "ingress-nginx"
  ingress_repo = "https://kubernetes.github.io/ingress-nginx"
  depends_on = [ module.eks ]
}