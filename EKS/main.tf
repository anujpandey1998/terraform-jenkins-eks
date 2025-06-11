# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "jenkins-vpc"
#   cidr = var.vpc_cidr

#   azs = data.aws_availability_zones.azs.names

#   private_subnets = var.private_subnets
#   public_subnets  = var.public_subnets

#   enable_dns_hostnames = true
#   enable_nat_gateway   = true
#   single_nat_gateway   = true

#   tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared"
#   }

#   public_subnet_tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared"
#     "kubernetes.io/role/elb"               = 1
#   }

#   private_subnet_tags = {
#     "kubernetes.io/cluster/my-eks-cluster" = "shared"
#     "kubernetes.io/role/internal-elb"      = 1
#   }

# }

# module "eks" {
#   source = "terraform-aws-modules/eks/aws"

#   cluster_name    = "my-eks-cluster"
#   cluster_version = "1.24"

#   cluster_endpoint_public_access = true

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets

#   eks_managed_node_groups = {
#     nodes = {
#       min_size     = 1
#       max_size     = 3
#       desired_size = 2

#       instance_type = ["t2.small"]
#     }
#   }

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }


terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  #region = "us-east-1"
  region = var.region
}

data "aws_availability_zones" "azs" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1" # latest stable version

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.13" # latest stable version as of mid-2025

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.small"] # Updated from t2, as t2 is now legacy
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
