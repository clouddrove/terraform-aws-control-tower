# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
locals {
  label_order = var.label_order
}

##----------------------------------------------VPC--------------------------------------------------------##
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = var.name
  environment = var.environment
  cidr_block  = var.cidr_block
}

##----------------------------------------------SUBNETS----------------------------------------------------##
module "subnet" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.0"

  name               = var.name
  environment        = var.environment
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  vpc_id             = module.vpc.vpc_id
  type               = var.subnet_type
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block

}

module "acm" {
  source  = "clouddrove/acm/aws"
  version = "1.4.0"

  name        = var.name
  environment = var.environment

  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}", "www.${var.domain}"]
}


module "route53" {
  source = "clouddrove/route53/aws"

  name        = var.name
  environment = var.environment

  public_enabled  = var.public_enabled
  private_enabled = var.private_enabled

  domain_name = var.domain_name
}
