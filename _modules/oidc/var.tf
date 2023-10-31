variable "name" {
  type        = string
  description = "Name for tags"
}

variable "repository" {
  type        = string
  description = "Repository name for tags"
}

variable "environment" {
  type        = string
  description = "Environment name for tags"
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "Managed by for tags"
}

variable "url" {
  type        = string
  description = "URL for the OIDC provider"
}

variable "oidc_github_repos" {
  type        = list(string)
  description = "GitHub repository names for access"
}

variable "role_name" {
  type        = string
  description = "Name of the AWS IAM Role to create"
}

variable "enable" {
  type        = bool
  default     = true
  description = "create aws oidc GitHUb role or not"
}

variable "oidc_provider_exists" {
  type        = bool
  default     = true
  description = "Mention oidc provider exist or not in true or false"
}

variable "policy_arns" {
  description = "A list of ARNs of policies to attach to the IAM role."
  type        = list(string)
}