terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.29.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "arcgis-pe2-vpc"
  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a"]
  public_subnets = ["10.0.1.0/24"]
  enable_nat_gateway = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"  

  cluster_name    = "arcgis-eks"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 1
      desired_size = 1
      instance_types = ["t3.micro"]
    }
  }
}

