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
  description = "Managed by"
}

variable "url" {
  type        = string
  description = "URL for the OIDC provider"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository to set IAM Role conditions for. Example: 'username/repo-name'"
}

variable "role_name" {
  type        = string
  description = "Name of the AWS IAM Role"
}
