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

## AWS-OIDC-GITHUB-ROLE

variable "oidc_enable" {
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
  default     = "GitHub-Deploy-Role"
  description = "Name of the AWS IAM Role to create"
}

variable "oidc_provider_exists" {
  type        = bool
  default     = false
  description = "Mention oidc provider exist or not in true or false"
}

variable "url" {
  type        = string
  default     = "https://token.actions.githubusercontent.com"
  description = "URL for the OIDC provider"
}

variable "policy_arns" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  description = "A list of ARNs of policies to attach to the IAM role."
}