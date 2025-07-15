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

  name = "arcgis-vpc"
  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_nat_gateway = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/arcgis-eks" = "owned"
    "Name" = "arcgis-public"
  }

  map_public_ip_on_launch = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"  

  cluster_name    = "arcgis-eks"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  
  cluster_endpoint_public_access  = true   
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 1
      desired_size = 1
      instance_types = ["t3.micro"]
    }
  }
}

