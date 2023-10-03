provider "aws" {
  region = var.region
}

#Module      : label
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  attributes  = var.attributes
  label_order = var.label_order
}

module "lambda_enable_macie" {
  source = "git@github.com:clouddrove/terraform-aws-lambda?ref=feat/issue_276_a"

  name                    = var.name
  environment             = var.environment
  enable                  = var.enable
  runtime                 = var.runtime
  handler                 = var.lambda_handler
  memory_size             = var.memory_size
  timeout                 = var.timeout
  description             = var.description
  iam_role_arn            = module.iam-role.arn
  filename                = var.filename
  enable_source_code_hash = var.enable_source_code_hash
  create_layers           = var.create_layers
  variables               = var.variables

  # lambda layer version
  compatible_runtimes = var.compatible_runtimes
  s3_buckets          = var.s3_buckets
  s3_keies            = var.s3_keies

  # lambda permission
  statement_ids = var.statement_ids
  actions       = var.actions
  principals    = var.principals
  source_arns   = [aws_cloudwatch_event_rule.life_cycle_rule_macie.arn]


}

resource "aws_cloudwatch_event_rule" "life_cycle_rule_macie" {
  name        = "amazon-macie-lifecycle"
  description = "Amazon Macie LifeCycle Trigger"
  event_pattern = jsonencode({
    source = [
      "aws.controltower"
    ]
    detail-type = [
      "AWS Service Event via CloudTrail"
    ]
    detail = {
      eventName = [
        "CreateManagedAccount"
      ]
    }
  })
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.life_cycle_rule_macie.name
  target_id = "NewAccount"
  arn       = module.lambda_enable_macie.arn
}

module "iam-role" {
  source             = "clouddrove/iam-role/aws"
  version            = "1.3.0"
  name               = "iam-role"
  environment        = var.environment
  label_order        = var.label_order
  enable             = var.enable
  assume_role_policy = data.aws_iam_policy_document.default.json
  policy_enabled     = true
  policy             = data.aws_iam_policy_document.iam-policy.json
}

data "aws_iam_policy_document" "default" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "iam-policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:iam::*:role/${var.assume_role}",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgId"
      values   = [var.organization_id]
    }
  }

  statement {
    actions = [
      "organizations:DeregisterDelegatedAdministrator",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:organizations::${var.aws_account_id}:account/${var.organization_id}/*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:logs:${var.region}:${var.aws_account_id}:*",
      "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:/aws/lambda/lambda-enable-macie:*",
    ]
  }

  statement {
    actions = [
      "organizations:RegisterDelegatedAdministrator",
      "organizations:ListAccounts",
      "organizations:ListDelegatedAdministrators",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:DescribeOrganization",
      "organizations:DisableAWSServiceAccess",
      "organizations:EnableAWSServiceAccess",
      "cloudformation:ListStackInstances",
      "macie2:EnableOrganizationAdminAccount",
      "macie2:DisableOrganizationAdminAccount",
      "macie2:ListOrganizationAdminAccounts",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}
