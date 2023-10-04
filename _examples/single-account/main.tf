locals {
  name        = "ct"
  environment = "network"
  region      = "us-east-1"
  role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/identos-test-sw-role"
  cidr_block  = "10.10.0.0/16"
}

data "aws_caller_identity" "current" {}



provider "aws" {
  region = local.region
}

provider "aws" {
  alias = "networking"
  assume_role {
    role_arn = local.role_arn
  }
  region = local.region
}

module "CT" {
  providers = {
    aws = aws.networking
  }
  source      = "../../"
  name        = local.name
  environment = local.environment
  region      = local.region

  ## VPC
  cidr_block = local.cidr_block

  ## SUBNET
  subnet_type = var.subnet_type

  ## SECURTIY-GROUP
  ssh_allow_ip = local.cidr_block

  ## ACM
  domain = var.domain

  ## Route53
  records = var.records

  ## TGW-HUB
  hub_destination_cidr = var.hub_destination_cidr

  ## VPN
  vpn_cidr_block = var.vpn_cidr_block
}