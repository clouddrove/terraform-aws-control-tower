# ------------------------------------------------------------------------------
# Common
# ------------------------------------------------------------------------------
variable "label_order" {
  type        = list(string)
  default     = ["environment", "name"]
  description = "Label order, e.g. `name`,`environment`."
}

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "region" {
  type        = string
  default     = ""
  description = "Region (e.g. `us-east-1`, `us-east-2`, `ap-south-1`)"
}

##----------------------------------------------VPC--------------------------------------------------------##
variable "vpc_enable" {
  type        = bool
  default     = true
  description = "Enable vpc to create or not."
}

variable "cidr_block" {
  type        = string
  default     = "10.10.0.0/16"
  description = "CIDR for the VPC."
}

variable "enable_flow_log" {
  type        = bool
  default     = true
  description = "Enable vpc_flow_log logs."
}

variable "flow_log_destination_type" {
  type        = string
  default     = "s3"
  description = "Type of flow log destination. Can be `s3` or `cloud-watch-logs`"
}

variable "create_flow_log_cloudwatch_iam_role" {
  type        = bool
  default     = true
  description = "Flag to be set true when cloudwatch iam role is to be created when flow log destination type is set to cloudwatch logs."
}

variable "flow_log_retention_period" {
  type        = number
  default     = null
  description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs"
}

variable "flow_log_destination_arn" {
  type        = string
  default     = null
  description = "ARN of destination where vpc flow logs are to stored. Can be of existing s3 or existing cloudwatch log group."
}

##----------------------------------------------SUBNET--------------------------------------------------------##
variable "subnet_enable" {
  type        = bool
  default     = true
  description = "Enable subnet to create or not."
}

variable "subnet_type" {
  type        = string
  default     = ""
  description = "Type of subnets to create (`private`, `public` or `public-private` )."
}

variable "nat_gateway_enabled" {
  type        = bool
  default     = false
  description = "Flag to enable/disable NAT Gateways creation in public subnets."
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Enable for only single NAT Gateway in one Availability Zone"
}

variable "public_inbound_acl_rules" {
  type = any
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
  }]
  description = "Public subnets inbound network ACLs"
}

variable "public_outbound_acl_rules" {
  type = any
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
  }]
  description = "Public subnets outbound network ACLs"
}

variable "private_inbound_acl_rules" {
  type = any
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
  }]
  description = "Private subnets inbound network ACLs"
}

variable "private_outbound_acl_rules" {
  type = any
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
  }]
  description = "Private subnets outbound network ACLs"
}

##----------------------------------------------SECURITY-GROUP----------------------------------------------------##
variable "sg_enable" {
  type        = bool
  default     = true
  description = "Whether or not to enable the entire SECURITY-GROUP module."
}

variable "ssh_allow_ip" {
  type        = string
  default     = ""
  description = "List of IP's to allowed for http_https traffic"
}

##----------------------------------------------TRANSIT-GATEWAY----------------------------------------------------##
##-----------------tgw_hub---------------------##
variable "tgw_hub_enable" {
  type        = bool
  default     = false
  description = "Enable subnet to create or not."
}

variable "tgw_hub_create" {
  type        = bool
  default     = true
  description = "Whether or not to create a Transit Gateway."
}

variable "tgw_hub_auto_accept_shared_attachments" {
  type        = string
  default     = "enable"
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "tgw_hub_description" {
  type        = string
  default     = "This transit gateway hub is created for centerlised vpc peering"
  description = "Description of the Hub Transit Gateway"
}

variable "tgw_hub_resource_share_enable" {
  type        = bool
  default     = true
  description = "Whether or not to create a Resource Share for the Transit Gateway."
}

variable "tgw_hub_resource_share_allow_external_principals" {
  type        = bool
  default     = true
  description = "Whether or not to allow external principals for the Resource Share for the Transit Gateway."
}

variable "tgw_hub_resource_share_account_ids" {
  type        = list(any)
  default     = []
  description = "Ids of the account where the Transit Gateway should be shared."
}

variable "tgw_hub_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC)."
}

variable "tgw_hub_transit_gateway_default_route_table_association" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

variable "tgw_hub_transit_gateway_default_route_table_propagation" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

##-----------------tgw_spoke-------------------##
variable "tgw_spoke_enable" {
  type        = bool
  default     = false
  description = "Enable subnet to create or not."
}

variable "tgw_spoke_create" {
  type        = bool
  default     = false
  description = "Whether or not to create a Transit Gateway."
}

variable "tgw_spoke_description" {
  type        = string
  default     = "This transit gateway spoke is created for centerlised vpc peering"
  description = "Description of the Spoke Transit Gateway"
}

variable "tgw_spoke_aws_ram_resource_share_accepter" {
  type        = bool
  default     = true
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "tgw_spoke_resource_share_arn" {
  type        = string
  default     = ""
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "tgw_spoke_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC 1)."
}

variable "tgw_spoke_transit_gateway_id" {
  type        = string
  default     = null
  description = "The ID of gateway id."
}

variable "tgw_spoke_transit_gateway_default_route_table_association" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

variable "tgw_spoke_transit_gateway_default_route_table_propagation" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

##----------------------------------------------ACM----------------------------------------------------##
variable "acm_enable" {
  type        = bool
  default     = true
  description = "Whether or not to enable the entire ACM module or not."
}

variable "domain" {
  type        = string
  default     = ""
  description = "A domain name for which the certificate should be issued."
}

variable "subject_alternative_names" {
  type        = list(any)
  default     = []
  description = "Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "Which method to use for validation, DNS or EMAIL."
}

##----------------------------------------------ROUTE53----------------------------------------------------##
variable "route53_enable" {
  type        = bool
  default     = true
  description = "Enable Route53 to create or not."
}

variable "private_enabled" {
  type        = bool
  default     = false
  description = "Whether to create private Route53 zone."
}

variable "public_enabled" {
  type        = bool
  default     = true
  description = "Whether to create public Route53 zone."
}

variable "record_enabled" {
  type        = bool
  default     = true
  description = "Whether to create Route53 record set."
}

variable "records" {
  type        = any
  default     = []
  description = "List of objects of DNS records"
}

variable "records_force_destroy" {
  type        = bool
  default     = true
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
}

##----------------------------------------------VPN----------------------------------------------------##
variable "vpn_enable" {
  type        = bool
  default     = false
  description = "Enable vpn to create or not."
}

variable "split_tunnel_enable" {
  type        = bool
  default     = false
  description = "Indicates whether split-tunnel is enabled on VPN endpoint."
}

variable "vpn_cidr_block" {
  type        = string
  default     = ""
  description = "Client VPN CIDR"
}

variable "vpn_route_cidr" {
  type        = list(any)
  default     = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
  description = "Client Route CIDR"
}

variable "vpn_network_cidr" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "Client Network CIDR"
}

variable "vpn_authentication_type" {
  type        = string
  default     = "certificate-authentication"
  description = "The type of client authentication to be used. Valid values are `federated-authentication` , `certificate-authentication`"
}

variable "saml_arn" {
  type        = string
  default     = ""
  description = "The ARN of the IAM SAML identity provider. "
}

variable "self_saml_arn" {
  type        = string
  default     = ""
  description = "The ARN of the IAM SAML identity provider for the self service portal. "
}

variable "vpn_organization_name" {
  type        = string
  default     = "clouddrove.ca"
  description = "Name of organization to use in private certificate"
}

##----------------------------------------oidc----------------------------------#
variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-control-tower.git"
  description = "Repository name for tags"
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "Managed by for tags"
}

variable "provider_url" {
  type        = string
  default     = "https://token.actions.githubusercontent.com"
  description = "URL for the OIDC provider"
}

variable "role_name" {
  type        = string
  default     = "github-oidc-terraform-role"
  description = "Name of the AWS IAM Role to create"
}

variable "aws_github_oidc_role_enable" {
  type        = bool
  default     = false
  description = "Create aws oidc GitHUb role or not"
}

variable "oidc_provider_exists" {
  type        = bool
  default     = false
  description = "Mention oidc provider exist or not in true or false"
}

variable "policy_arns" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  description = "A list of ARNs of policies to attach to the IAM role."
}

variable "oidc_github_repos" {
  type        = list(string)
  default     = [""]
  description = "GitHub repository names for access"
}