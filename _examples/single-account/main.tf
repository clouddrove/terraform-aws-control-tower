# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
locals {
  name        = "ct"
  environment = "networking"
  region      = "us-east-1"
}

module "CT" {
  source      = "../../"
  name        = local.name
  environment = local.environment

  cidr_block  = var.cidr_block
  subnet_type = var.subnet_type
}