# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

## VPC
variable "cidr_block" {
 description = "CIDR for the VPC."
}

## SUBNET
variable "subnet_type" {
 description = "Type of subnets to create (`private` or `public`)."
}

## ACM
variable "domain" {
 description = "A domain name for which the certificate should be issued."
}

## Route53
variable "records" {
 description = "List of objects of DNS records"
}

## TGW-HUB
variable "hub_destination_cidr" {
 description = "The destination CIDR block (VPC 1)."
}

## VPN
variable "vpn_cidr_block" {
 description = "Client VPN CIDR"
}