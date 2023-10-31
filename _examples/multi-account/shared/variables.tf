# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

## SUBNET
variable "subnet_type" {
  type        = string
  default     = ""
  description = "Type of subnets to create (`private` or `public`)."
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
variable "tgw_spoke_enable" {
  type        = bool
  default     = true
  description = "Enable subnet to create or not."
}

variable "transit_gateway_id" {
  type        = string
  default     = ""
  description = "The ID of gateway id."
}

variable "spoke_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC)."
}

variable "resource_share_arn" {
  type        = string
  default     = ""
  description = "Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable."
}