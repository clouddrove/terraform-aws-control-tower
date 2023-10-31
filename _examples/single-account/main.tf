locals {
  name        = "ct"
  environment = "networking"
  region      = "us-east-1"
  role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/CT-networking-test-sw"
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
  cidr_block                = local.cidr_block
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_type = var.flow_log_destination_type

  ## SUBNET
  subnet_type         = var.subnet_type
  nat_gateway_enabled = var.nat_gateway_enabled
  single_nat_gateway  = var.single_nat_gateway

  ## SECURTIY-GROUP
  ssh_allow_ip = local.cidr_block

  ## ACM
  domain = var.domain

  ## Route53
  records = var.records

  ## TGW-HUB
  tgw_hub_enable                     = var.tgw_hub_enable
  tgw_hub_destination_cidr           = var.hub_destination_cidr
  tgw_hub_resource_share_account_ids = var.resource_share_account_ids

  ## VPN
  vpn_enable     = var.vpn_enable
  vpn_cidr_block = var.vpn_cidr_block
}