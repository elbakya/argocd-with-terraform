terraform {
  required_version = ">= 1.3.9"

  backend "s3" {
    bucket    = "final-task-brainscale-backends3"
    key       = "state/terraform.tfstate"
    encrypt   = true
    region    = "eu-central-1"  
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.17"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}


provider "kubernetes" {
  host = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode (module.eks.eks_cluster_auth_data)
  exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name]
  }
}

provider "helm" {
    kubernetes {
      host = module.eks.eks_cluster_endpoint
      cluster_ca_certificate = base64decode(module.eks.eks_cluster_auth_data)

      exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        command = "aws"
        args = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name]
      }
   }
}
