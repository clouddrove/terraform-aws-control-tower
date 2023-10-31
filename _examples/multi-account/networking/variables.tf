# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

## SUBNET
variable "subnet_type" {
  type        = string
  default     = ""
  description = "Type of subnets to create (`private` or `public`)."
}

variable "nat_gateway_enabled" {
  type        = bool
  default     = true
  description = "Flag to enable/disable NAT Gateways creation in public subnets."
}

variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "Enable for only single NAT Gateway in one Availability Zone"
}

## ACM
variable "domain" {
  type        = string
  default     = ""
  description = "A domain name for which the certificate should be issued."
}

## Route53
variable "records" {
  type        = any
  default     = []
  description = "List of objects of DNS records"
}

## TGW-HUB
variable "tgw_hub_enable" {
  type        = bool
  default     = true
  description = "Enable subnet to create or not."
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

## VPN
variable "vpn_enable" {
  type        = bool
  default     = true
  description = "Enable vpn to create or not."
}

variable "vpn_cidr_block" {
  type        = string
  default     = ""
  description = "Client VPN CIDR"
}