################################################################################
# backend
################################################################################
terraform {
  backend "s3" {
    bucket = "eks-automated-s3-bucket"
    key    = "ct/dev.tfstate"
    region = "us-east-1"
  }
}