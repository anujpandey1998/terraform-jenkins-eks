terraform {
  backend "s3" {
    bucket = "cicd-eks-terraform-project"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}