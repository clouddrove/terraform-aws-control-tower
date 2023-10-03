locals {
  name                 = "ct"
  environment          = "network"
  region               = "us-east-1"
  domain               = "identos.ca"
  role_arn             = "arn:aws:iam::924144197303:role/identos-test-sw-role"
  cidr_block           = "10.10.0.0/16"
  subnet_type          = "private"
  records              = []
  hub_destination_cidr = ["10.11.0.0/16"]
  vpn_cidr_block       = "172.16.0.0/16"

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
  cidr_block = local.cidr_block

  ## SUBNET
  subnet_type = local.subnet_type

  ## SECURTIY-GROUP
  ssh_ingress_allow_ip        = [local.cidr_block]
  http_https_ingress_allow_ip = [local.cidr_block]

  ## ACM
  domain = local.domain

  ## Route53
  record_enabled = true
  records        = local.records

  ## TGW-HUB
  hub_destination_cidr = local.hub_destination_cidr

  ## VPN
  vpn_cidr_block = local.vpn_cidr_block
}