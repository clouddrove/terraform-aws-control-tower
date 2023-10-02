locals {
  name        = "ct"
  environment = "network"
  region      = "us-east-1"
  domain      = "identos.ca"
  role_arn    = "arn:aws:iam::123456789012:role/role-name"
  cidr_block  = "10.10.0.0/16"
  subnet_type = "private"

}

provider "aws" {
  region = local.region
}

provider "aws" {
  alias = "networking"
  # assume_role {
  #   role_arn = local.role_arn
  # }
  region = local.region
}
module "CT" {
  source      = "../../"
  name        = local.name
  environment = local.environment
  region      = local.region

  ## VPC
  cidr_block = local.cidr_block

  ## SUBNET
  subnet_type = local.subnet_type

  ## SECURTIY-GROUP
  ssh_ingress_allow_ip = [local.cidr_block]
  http_https_ingress_allow_ip = [local.cidr_block]

  ## ACM
  domain = local.domain

  ## Route53
  record_enabled = true
  records        = []
}