# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

## VPC
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

## AWS-OIDC-GITHUB-ROLE

variable "aws_github_oidc_role_enable" {
  type        = bool
  default     = true
  description = "Create aws oidc GitHUb role or not"
}

variable "oidc_github_repos" {
  type        = list(string)
  default     = ["clouddrove/terraform-aws-control-tower"]
  description = "GitHub repository names for access"
}

variable "role_name" {
  type        = string
  default     = "github-oidc-terraform-role"
  description = "Name of the AWS IAM Role to create"
}

variable "oidc_provider_exists" {
  type        = bool
  default     = false
  description = "Mention oidc provider exist or not in true or false"
}

variable "provider_url" {
  type        = string
  default     = "https://token.actions.githubusercontent.com"
  description = "provider_url for the OIDC provider"
}

variable "policy_arns" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  description = "A list of ARNs of policies to attach to the IAM role."
}