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
variable "ssh_ingress_allow_ip" {
  type = list(string)
  default = [ "" ]
  description = "List of IP's to allowed for http_https traffic"
}

variable "http_https_ingress_allow_ip" {
  type = list(string)
  default = [ "" ]
  description = "List of IP's to allowed for http_https traffic"
}

variable "ssh_egress_rule" {
  type = any
  default = [{
    rule_count       = 1
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all traffic."
  }]
  description = "Egress rules with only cidr_blockd. Should be used when new security group is been deployed."
}

variable "http_https_egress_rule" {
  type = any
  default = [{
    rule_count       = 1
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all traffic."
  }]
  description = "Egress rules with only cidr_blockd. Should be used when new security group is been deployed."
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
  description = "Enable subnet to create or not."
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
  description = "List of objects of DNS records"
  type        = any
  default     = []
}