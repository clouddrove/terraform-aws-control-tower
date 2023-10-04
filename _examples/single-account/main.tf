locals {
  name        = "ct"
  environment = "network"
  region      = "us-east-1"
  role_arn    = "arn:aws:iam::924144197303:role/identos-test-sw-role"
}

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
  cidr_block = var.cidr_block

  ## SUBNET
  subnet_type = var.subnet_type

  ## SECURTIY-GROUP
  ssh_allow_ip = var.cidr_block

  ## ACM
  domain = var.domain

  ## Route53
  record_enabled = true
  records        = var.records

  ## TGW-HUB
  hub_destination_cidr = var.hub_destination_cidr

  ## VPN
  vpn_cidr_block = var.vpn_cidr_block
}