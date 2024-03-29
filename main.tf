##---------------------------------------------------------------------------------------------------------##
# Resources
##---------------------------------------------------------------------------------------------------------##

##----------------------------------------------VPC--------------------------------------------------------##
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "${var.name}-vpc"
  environment = var.environment
  label_order = var.label_order

  enable                                          = var.vpc_enable
  cidr_block                                      = var.cidr_block
  enable_flow_log                                 = var.enable_flow_log
  flow_log_destination_type                       = var.flow_log_destination_type
  create_flow_log_cloudwatch_iam_role             = var.create_flow_log_cloudwatch_iam_role
  flow_logs_bucket_name                           = var.flow_log_destination_type == "s3" ? "${var.name}-${var.environment}-vpc-flow-logs-bucket" : ""
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_retention_period
  flow_log_destination_arn                        = var.flow_log_destination_arn
}

##----------------------------------------------SUBNETS----------------------------------------------------##
module "subnet" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.1"

  name        = "${var.name}-subnet"
  environment = var.environment
  label_order = var.label_order

  enable                     = var.subnet_enable
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

  name        = "${var.name}-ssh"
  environment = var.environment
  label_order = var.label_order

  enable              = var.sg_enable
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

  name        = "${var.name}-tgw"
  environment = var.environment
  label_order = var.label_order

  depends_on                     = [module.vpc, module.subnet]
  enable                         = var.tgw_hub_enable
  tgw_create                     = var.tgw_hub_create
  auto_accept_shared_attachments = var.tgw_hub_auto_accept_shared_attachments
  description                    = var.tgw_hub_description
  # -- TGW Share
  resource_share_enable                    = var.tgw_hub_resource_share_enable
  resource_share_allow_external_principals = var.tgw_hub_resource_share_allow_external_principals
  resource_share_account_ids               = var.tgw_hub_resource_share_account_ids
  # -- VPC Attachements
  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.subnet.private_subnet_id
      transit_gateway_default_route_table_association = var.tgw_hub_transit_gateway_default_route_table_association
      transit_gateway_default_route_table_propagation = var.tgw_hub_transit_gateway_default_route_table_propagation
      vpc_route_table_ids                             = module.subnet.private_route_tables_id
      destination_cidr                                = var.tgw_hub_destination_cidr
    }
  }
}

module "tgw_spoke" {
  source  = "clouddrove/transit-gateway/aws"
  version = "2.0.0"

  name        = "${var.name}-tgw"
  environment = var.environment
  label_order = var.label_order

  depends_on  = [module.vpc, module.subnet]
  enable      = var.tgw_spoke_enable
  tgw_create  = var.tgw_spoke_create
  description = var.tgw_spoke_description
  # -- TGW Share
  aws_ram_resource_share_accepter = var.tgw_spoke_aws_ram_resource_share_accepter
  resource_share_arn              = var.tgw_spoke_resource_share_arn
  # -- VPC Attachements
  transit_gateway_id = var.tgw_spoke_transit_gateway_id
  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.subnet.private_subnet_id
      transit_gateway_default_route_table_association = var.tgw_spoke_transit_gateway_default_route_table_association
      transit_gateway_default_route_table_propagation = var.tgw_spoke_transit_gateway_default_route_table_propagation
      vpc_route_table_ids                             = module.subnet.private_route_tables_id
      destination_cidr                                = var.tgw_spoke_destination_cidr
    }
  }
}

#----------------------------------------------ACM----------------------------------------------------##
module "acm" {
  source  = "clouddrove/acm/aws"
  version = "1.4.1"

  name        = "${var.name}-certificate"
  environment = var.environment
  label_order = var.label_order

  enable                    = var.acm_enable
  domain_name               = var.domain
  validation_method         = var.validation_method
  subject_alternative_names = length(var.subject_alternative_names) > 0 ? var.subject_alternative_names : ["*.${var.domain}"]
}

#----------------------------------------------ROUTE53----------------------------------------------------##
module "route53" {
  source  = "clouddrove/route53/aws"
  version = "1.0.2"

  name        = var.name
  environment = var.environment
  label_order = var.label_order

  enabled         = var.route53_enable
  public_enabled  = var.public_enabled
  private_enabled = var.private_enabled
  domain_name     = var.domain
  record_enabled  = var.record_enabled
  records         = var.records
  vpc_id          = module.vpc.vpc_id
  force_destroy   = var.records_force_destroy
}

#----------------------------------------------VPN----------------------------------------------------##
module "vpn" {
  source  = "clouddrove/client-vpn/aws"
  version = "1.0.7"

  name        = "${var.name}-client-vpn"
  environment = var.environment
  label_order = var.label_order

  depends_on          = [module.vpc]
  enabled             = var.vpn_enable
  split_tunnel_enable = var.split_tunnel_enable
  cidr_block          = var.vpn_cidr_block
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.subnet.private_subnet_id
  route_cidr          = var.vpn_route_cidr
  route_subnet_ids    = module.subnet.private_subnet_id
  network_cidr        = var.vpn_network_cidr
  organization_name   = var.vpn_organization_name
  dns_names           = [var.domain]
  authentication_type = var.vpn_authentication_type
  saml_arn            = var.saml_arn
  self_saml_arn       = var.self_saml_arn
}

#----------------------------------------------aws-oidc-github-role----------------------------------------------------##
module "aws_github_oidc_role" {
  source = "./_modules/aws_github_oidc_role"

  enable               = var.aws_github_oidc_role_enable
  name                 = var.name
  environment          = var.environment
  managedby            = var.managedby
  repository           = var.repository
  provider_url         = var.provider_url
  oidc_github_repos    = var.oidc_github_repos
  role_name            = var.role_name
  policy_arns          = var.policy_arns
  oidc_provider_exists = var.oidc_provider_exists
}