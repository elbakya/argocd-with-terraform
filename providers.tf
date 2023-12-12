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


