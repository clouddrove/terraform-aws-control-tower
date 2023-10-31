variable "name" {
  type        = string
  description = "Name for the AWS IAM OpenID Connect Provider"
}

variable "repository" {
  type        = string
  description = "Repository name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "Managed by"
}

variable "url" {
  type        = string
  description = "URL for the OIDC provider"
}

variable "github_repos" {
  type        = list(string)
  description = "GitHub repository names"
}

variable "role_name" {
  type        = string
  description = "Name of the AWS IAM Role"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Name of the AWS IAM Role"
}
