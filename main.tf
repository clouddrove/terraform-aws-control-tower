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
  flow_logs_bucket_name     = "${var.name}-${var.environment}-vpc-logs-bucket"
}

##----------------------------------------------SUBNETS----------------------------------------------------##
module "subnet" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.0"

  enable                     = var.subnet_enable
  name                       = var.name
  environment                = var.environment
  nat_gateway_enabled        = var.nat_gateway_enabled
  single_nat_gateway         = var.single_nat_gateway
  availability_zones         = ["${var.region}a", "${var.region}b", "${var.region}c"]
  vpc_id                     = module.vpc.vpc_id
  type                       = var.subnet_type
  igw_id                     = module.vpc.igw_id
  cidr_block                 = module.vpc.vpc_cidr_block
  public_inbound_acl_rules   = var.public_inbound_acl_rules
  public_outbound_acl_rules  = var.public_outbound_acl_rules
  private_inbound_acl_rules  = var.private_inbound_acl_rules
  private_outbound_acl_rules = var.private_outbound_acl_rules
}

##----------------------------------------------SECURITY-GROUP----------------------------------------------------##
module "ssh" {
  source  = "clouddrove/security-group/aws"
  version = "2.0.0"

  enable              = var.sg_enable
  name                = "${var.name}-ssh"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  prefix_list_enabled = true
  entry = [{
    cidr = var.ssh_allow_ip
  }]
  ## INGRESS Rules
  new_sg_ingress_rules_with_prefix_list = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "Allow ingress ssh traffic."
    }
  ]
  ## EGRESS Rules
  new_sg_egress_rules_with_prefix_list = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "Allow egress ssh traffic."
    }
  ]

}

#----------------------------------------------TRANSIT-GATEWAY----------------------------------------------------##
module "tgw_hub" {
  source  = "clouddrove/transit-gateway/aws"
  version = "2.0.0"

  enable                         = var.tgw_hub_enable
  depends_on                     = [module.vpc, module.subnet]
  name                           = var.name
  environment                    = var.environment
  tgw_create                     = var.hub_tgw_create
  auto_accept_shared_attachments = var.hub_auto_accept_shared_attachments
  description                    = var.description
  #TGW Share
  resource_share_enable                    = var.resource_share_enable
  resource_share_allow_external_principals = var.resource_share_allow_external_principals
  resource_share_account_ids               = var.resource_share_account_ids
  # VPC Attachements
  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.subnet.private_subnet_id
      transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
      transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
      vpc_route_table_ids                             = module.subnet.private_route_tables_id
      destination_cidr                                = var.hub_destination_cidr
    }
  }
}

module "tgw_spoke" {
  source  = "clouddrove/transit-gateway/aws"
  version = "2.0.0"

  enable      = var.tgw_spoke_enable
  depends_on  = [module.vpc, module.subnet]
  name        = var.name
  environment = var.environment
  tgw_create  = var.spoke_tgw_create
  description = var.description
  #TGW Share
  aws_ram_resource_share_accepter = var.aws_ram_resource_share_accepter
  resource_share_arn              = var.resource_share_arn
  # VPC Attachements
  transit_gateway_id = var.transit_gateway_id
  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.subnet.private_subnet_id
      transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
      transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
      vpc_route_table_ids                             = module.subnet.private_route_tables_id
      destination_cidr                                = var.spoke_destination_cidr
    }
  }
}

#----------------------------------------------ACM----------------------------------------------------##
module "acm" {
  source  = "clouddrove/acm/aws"
  version = "1.4.1"

  name        = var.name
  environment = var.environment

  enable                    = var.acm_enable
  domain_name               = var.domain
  validation_method         = var.validation_method
  subject_alternative_names = ["*.${var.domain}", "www.${var.domain}"]
}

#----------------------------------------------ROUTE53----------------------------------------------------##
module "route53" {
  source  = "clouddrove/route53/aws"
  version = "1.0.2"

  name            = var.name
  enabled         = var.route53_enable
  environment     = var.environment
  public_enabled  = var.public_enabled
  private_enabled = var.private_enabled

  domain_name    = var.domain
  record_enabled = var.record_enabled
  records        = var.records
  vpc_id         = module.vpc.vpc_id
}

#----------------------------------------------VPN----------------------------------------------------##
module "vpn" {
  source  = "clouddrove/client-vpn/aws"
  version = "1.0.7"

  enabled             = var.vpn_enable
  name                = var.name
  environment         = var.environment
  split_tunnel_enable = var.split_tunnel_enable
  cidr_block          = var.vpn_cidr_block
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.subnet.private_subnet_id
  route_cidr          = var.vpn_route_cidr
  route_subnet_ids    = module.subnet.private_subnet_id
  network_cidr        = var.vpn_network_cidr
  organization_name   = var.vpn_organization_name
  dns_names           = [var.domain]
  saml_arn            = var.saml_arn
}

#----------------------------------------------aws-oidc-github-role----------------------------------------------------##

module "aws_oidc_role" {
  source = "./_module/oidc"

  enable      = var.oidc_enable
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  url         = var.url
  github_repo = var.github_repo
  role_name   = var.role_name
}