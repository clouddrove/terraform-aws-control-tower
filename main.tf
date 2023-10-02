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

  enable                    = var.vpc_enable
  name                      = var.name
  environment               = var.environment
  cidr_block                = var.cidr_block
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_type = var.flow_log_destination_type
  flow_logs_bucket_name     = "${var.name}-vpc-logs-bucket"
}

##----------------------------------------------SUBNETS----------------------------------------------------##
module "subnet" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.0"

  enable             = var.subnet_enable
  name               = var.name
  environment        = var.environment
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  vpc_id             = module.vpc.vpc_id
  type               = var.subnet_type
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
}

##----------------------------------------------SECURITY-GROUP----------------------------------------------------##
module "ssh" {
  source  = "clouddrove/security-group/aws"
  version = "2.0.0"

  name        = "${var.name}-ssh"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  new_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = var.ssh_ingress_allow_ip
    description = "Allow ssh traffic."
    }
  ]
  new_sg_egress_rules_with_cidr_blocks = var.ssh_egress_rule
}

module "http_https" {
  source  = "clouddrove/security-group/aws"
  version = "2.0.0"

  name        = "${var.name}-http-https"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  new_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 2
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = var.http_https_ingress_allow_ip
    description = "Allow http traffic."
    },
    {
      rule_count  = 3
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
      cidr_blocks = var.http_https_ingress_allow_ip
      description = "Allow https traffic."
  }]
  new_sg_egress_rules_with_cidr_blocks = var.http_https_egress_rule
}

##----------------------------------------------TRANSIT-GATEWAY----------------------------------------------------##
module "tgw_hub" {
  source                          = "clouddrove/transit-gateway/aws"
  version                         = "2.0.0"

  depends_on                      = [module.vpc, module.subnet]
  name                            = var.name
  environment                     = var.environment
  tgw_create                      = var.tgw_create
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_propagation = var.default_route_table_propagation
  description                     = var.description
  #TGW Share
  resource_share_enable                    = var.resource_share_enable
  resource_share_allow_external_principals = var.resource_share_allow_external_principals
  # resource_share_account_ids               = var.resource_share_account_ids
  # VPC Attachements
  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.subnet.private_subnet_id
      transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
      transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
      # Below should be uncommented only when vpc and subnet are already deployed.
      vpc_route_table_ids = module.dmz_subnet.public_route_tables_id
      destination_cidr    = var.destination_cidr_1
    }
  }
}


##----------------------------------------------ACM----------------------------------------------------##
module "acm" {
  source  = "clouddrove/acm/aws"
  version = "1.4.0"

  name        = var.name
  environment = var.environment

  domain_name               = var.domain
  validation_method         = var.validation_method
  subject_alternative_names = ["*.${var.domain}", "www.${var.domain}"]
}

##----------------------------------------------ROUTE53----------------------------------------------------##
module "route53" {
  source = "clouddrove/route53/aws"
  version = "1.0.2"

  name        = var.name
  enabled     = var.route53_enable
  environment = var.environment
  public_enabled  = var.public_enabled
  private_enabled = var.private_enabled

  domain_name = var.domain
  record_enabled = var.record_enabled
  records     = var.records
  vpc_id      = module.vpc.vpc_id
}
