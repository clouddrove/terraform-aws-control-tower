locals {
  name        = "ct"
  environment = "networking"
  region      = "us-east-1"
  domain      = "identos.ca"
  role_arn    = "arn:aws:iam::123456789012:role/role-name"
  cidr_block  = "10.0.10.0/16"
  subnet_type = private

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
  source      = "../../"
  name        = local.name
  environment = local.environment

  cidr_block  = local.cidr_block
  subnet_type = local.subnet_type

  ## ACM
  domain_name = local.domain
}

## Route53
record_enabled = true
public_enabled = true
records = [
  {},
  {},
]