locals {
  name        = "ct"
  environment = "networking"
  region      = "us-east-1"
  domain      = "identos.ca"
}

provider "aws" {
  region = local.region
}

module "CT" {
  source      = "../../"
  name        = local.name
  environment = local.environment

  cidr_block  = "10.0.10.0/16"
  subnet_type = private

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