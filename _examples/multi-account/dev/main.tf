locals {
  name        = "ct"
  environment = "dev"
  region      = "us-east-1"
  role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/CT-networking-test-sw" #Provide dev account role ARN
  cidr_block  = "10.12.0.0/16"
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

module "control_tower" {
  providers = {
    aws = aws.networking
  }
  source      = "../../../"
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
  tgw_spoke_enable             = var.tgw_spoke_enable
  tgw_spoke_destination_cidr   = var.spoke_destination_cidr
  tgw_spoke_transit_gateway_id = var.transit_gateway_id
  tgw_spoke_resource_share_arn = var.resource_share_arn
}