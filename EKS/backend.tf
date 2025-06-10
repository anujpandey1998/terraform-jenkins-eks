terraform {
  backend "s3" {
    bucket = "cicd-eks-terraform-project"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
