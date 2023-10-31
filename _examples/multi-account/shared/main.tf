locals {
  name        = "ct"
  environment = "shared"
  region      = "us-east-1"
  role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/CT-networking-test-sw" # Provide shared account role ARN
  cidr_block  = "10.11.0.0/16"
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
  tgw_spoke_enable       = var.tgw_spoke_enable
  spoke_destination_cidr = var.spoke_destination_cidr
  transit_gateway_id     = var.transit_gateway_id
  resource_share_arn     = var.resource_share_arn

  ## AWS-OIDC-GITHUB-ROLE
  oidc_enable          = var.oidc_enable
  oidc_github_repos    = var.oidc_github_repos
  role_name            = var.role_name
  oidc_provider_exists = var.oidc_provider_exists
  url                  = var.url
  policy_arns          = var.policy_arns
}