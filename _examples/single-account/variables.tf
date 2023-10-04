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
variable "hub_destination_cidr" {
  type        = list(any)
  default     = []
  description = "The destination CIDR block (VPC)."
}

## VPN
variable "vpn_cidr_block" {
  type        = string
  default     = ""
  description = "Client VPN CIDR"
}