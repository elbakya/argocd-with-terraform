
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.16"

  cluster_name    = "${var.cluster_name}"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "${var.vpc_id_for_eks}"
  subnet_ids               = "${var.vpc_public_subnets}"
  #control_plane_subnet_ids = module.vpc.public_subnets
  enable_irsa = true
  node_security_group_id =  "${var.sg_id}"
  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "t3.medium"
    update_launch_template_default_version = true
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
  }
  eks_managed_node_groups = {
    default_node_group = {
      name = "my-cluster-managed"
      use_name_prefix = false
      use_custom_launch_template = false
      subnet_ids = "${var.vpc_public_subnets}"
      instance_types = ["t3.medium"]
      disk_size = 30

      min_size     = 1
      desired_size = 1
      max_size     = 3
      tags = {
        Name = "my-cluster-managed"
      }
    }
  }

  # aws-auth configmap
  #create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::261033416540:role/eksClusterRole"
      username = "eksClusterRole"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::261033416540:user/intern_user"
      username = "intern_user"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_accounts = [
    "261033416540"
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
