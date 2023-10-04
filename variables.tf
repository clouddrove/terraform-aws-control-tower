# ------------------------------------------------------------------------------
# Common
# ------------------------------------------------------------------------------
variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
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
  default     = ""
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
  description = "Type of flow log destination. Can be s3 or cloud-watch-logs"
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
  description = "Type of subnets to create (`private` or `public`)."
}

##----------------------------------------------SECURITY-GROUP----------------------------------------------------##
variable "ssh_allow_ip" {
  type        = string
  default     = ""
  description = "List of IP's to allowed for http_https traffic"
}

##----------------------------------------------TRANSIT-GATEWAY----------------------------------------------------##
variable "tgw_hub_enable" {
  type        = bool
  default     = true
  description = "Enable subnet to create or not."
}

variable "hub_tgw_create" {
  type        = bool
  default     = true
  description = "Whether or not to create a Transit Gateway."
}

variable "hub_auto_accept_shared_attachments" {
  type        = string
  default     = "enable"
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "description" {
  type        = string
  default     = ""
  description = "This transit Gateway is created for centerlised vpc peering"
}

variable "resource_share_enable" {
  type        = bool
  default     = true
  description = "Whether or not to create a Resource Share for the Transit Gateway."
}

variable "resource_share_allow_external_principals" {
  type        = bool
  default     = true
  description = "Whether or not to allow external principals for the Resource Share for the Transit Gateway."
}

variable "resource_share_account_ids" {
  type        = list(any)
  default     = []
  description = "Ids of the account where the Transit Gateway should be shared."
}

variable "hub_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC)."
}

variable "transit_gateway_default_route_table_association" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

variable "transit_gateway_default_route_table_propagation" {
  type        = bool
  default     = true
  description = "Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true."
}

## SPOKE
variable "tgw_spoke_enable" {
  type        = bool
  default     = false
  description = "Enable subnet to create or not."
}

variable "spoke_tgw_create" {
  type        = bool
  default     = false
  description = "Whether or not to create a Transit Gateway."
}

variable "aws_ram_resource_share_accepter" {
  type        = bool
  default     = true
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "resource_share_arn" {
  type        = string
  default     = ""
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}

variable "spoke_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC 1)."
}

variable "transit_gateway_id" {
  type        = string
  default     = null
  description = "The ID of gateway id."
}

##----------------------------------------------ACM----------------------------------------------------##
variable "domain" {
  type        = string
  default     = ""
  description = "A domain name for which the certificate should be issued."
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
  default     = false
  description = "Whether to create Route53 record set."
}

variable "records" {
  type        = any
  default     = []
  description = "List of objects of DNS records"
}

##----------------------------------------------VPN----------------------------------------------------##
variable "vpn_enable" {
  type        = bool
  default     = true
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

variable "saml_arn" {
  type        = string
  default     = ""
  description = "The ARN of the IAM SAML identity provider. "
}