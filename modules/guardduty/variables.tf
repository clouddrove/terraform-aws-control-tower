variable "name" {
  type        = string
  default     = "GuardDutyEnablerLambda"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = null
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["environment", "name"]
  description = "Label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "managedby" {
  type        = string
  default     = "test"
  description = "ManagedBy,"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Whether to create lambda function."
}

variable "create_layers" {
  type        = bool
  default     = false
  description = "Flag to control creation of lambda layers."
}

variable "role_name" {
  type        = string
  default     = "GuardDutyEnablerRole"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "assume_role" {
  type        = string
  default     = "AWSControlTowerExecution"
  description = "What role should be assumed in accounts to enable GuardDuty? The Default is AWSControlTowerExecution for a Control Tower environment."
}

variable "policy_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable the policy in IAM."
}

variable "control_tower_management_account" {
  type        = string
  default     = null
  description = "ID of the AWS Control Tower Management account, where we deployed the Control Tower service."
}

variable "security_account_id" {
  type        = string
  default     = ""
  description = "The AWS Control Tower Audit account"
}

variable "organization_id" {
  type        = string
  default     = ""
  description = "AWS Organizations ID for the Control Tower"
}

variable "region_filter" {
  type        = string
  default     = "ControlTower"
  description = "GuardDuty should be enabled for all Security Hub supported regions, or only Control Tower supported regions"
}

variable "create_iam_role" {
  type        = bool
  default     = false
  description = "Flag to control creation of iam role and its related resources."
}

variable "subnet_ids" {
  type        = list(any)
  default     = null
  description = "Subnet ids for vpc config."
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = null
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
}

variable "runtime" {
  type        = string
  default     = "python3.7"
  description = "Runtimes."
}

variable "timeout" {
  type        = number
  default     = 10
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
}

variable "handler" {
  type        = string
  default     = "guardduty_enabler.lambda_handler"
  description = "The function entrypoint in your code."
}

variable "actions" {
  type        = list(any)
  default     = ["lambda:InvokeFunction", "lambda:InvokeFunction", "lambda:InvokeFunction"]
  description = "The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)."
}

variable "principals" {
  type        = list(any)
  default     = ["sns.amazonaws.com", "events.amazonaws.com", "events.amazonaws.com"]
  description = "The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
}

variable "filename" {
  type        = string
  default     = "../code/guardduty_enabler.zip"
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Boolean indicating whether or not to create sns module."
}

variable "enable_sns" {
  type        = bool
  default     = false
  description = "Boolean indicating whether or not to create sns."
}

variable "enable_topic" {
  type        = bool
  default     = true
  description = "Boolean indicating whether or not to create topic."
}

variable "endpoint_auto_confirms" {
  type        = bool
  default     = true
  description = "Boolean indicating whether the end point is capable of auto confirming subscription."
}

variable "raw_message_delivery" {
  type        = bool
  default     = false
  description = "Boolean indicating whether or not to enable raw message delivery."
}

variable "filter_policy" {
  type        = string
  default     = ""
  description = "JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource."
}

variable "delivery_policy" {
  type        = string
  default     = ""
  description = "JSON String with the delivery policy (retries, backoff, etc.) that will be used in the subscription - this only applies to HTTP/S subscriptions."
}

variable "confirmation_timeout_in_minutes" {
  type        = number
  default     = 60
  description = " Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols."
}

variable "sns_name" {
  type        = string
  default     = "GuardDutyEnablerTopic"
  description = "The display name for the SNS topic."
}

variable "display_name" {
  type        = string
  default     = "GuardDuty_Enabler"
  description = "The display name for the SNS topic."
}

variable "topic_name" {
  type        = string
  default     = "guarddutyenablertopic"
  description = "The friendly name for the SNS topic. By default generated by Terraform."
}

variable "protocol" {
  type        = string
  default     = "lambda"
  description = "The protocol to use. The possible values for this are: sqs, sms, lambda, application."
}

variable "life_cycle_rule_name" {
  type        = string
  default     = "amazon-guardduty-lifecycle"
  description = "Name of the Cloudwatch LifeCycle event rule for GuardDuty"
}

variable "life_cycle_rule_description" {
  type        = string
  default     = "Amazon GuardDuty LifeCycle Trigger"
  description = "Description of the Cloudwatch LifeCycle event rule for GuardDuty"
}

variable "schedule_rule_name" {
  type        = string
  default     = "amazon-guardduty-schedule-compliance"
  description = "Name of the Cloudwatch Schedule event rule for GuardDuty"
}

variable "schedule_rule_description" {
  type        = string
  default     = "Amazon GuardDuty Schedule Compliance Trigger"
  description = "Description of the Cloudwatch Schedule event rule for GuardDuty"
}

variable "compliance_frequency" {
  type        = number
  default     = 60
  description = "How frequently (in minutes, between 1 and 3600, default is 60) should organizational compliance be checked?"
}
