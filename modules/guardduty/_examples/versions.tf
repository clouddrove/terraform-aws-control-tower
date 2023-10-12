# Terraform version
terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"  
    }
  }
}