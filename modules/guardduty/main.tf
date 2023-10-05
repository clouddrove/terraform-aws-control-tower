data "aws_partition" "current" {}
data "aws_region" "current" {}

# Create IAM Role for GuardDuty Enabler
module "iam-role" {
  source             = "clouddrove/iam-role/aws"
  version            = "1.3.0"
  name               = var.role_name
  environment        = var.environment
  label_order        = var.label_order
  enabled            = var.enabled
  assume_role_policy = data.aws_iam_policy_document.default.json
  policy_enabled     = true
  policy             = data.aws_iam_policy_document.iam-policy.json

  tags = {
    Name = var.role_name
  }
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
    effect = "Allow"
    actions = [
      "organizations:ListAccounts",
      "organizations:DescribeAccount",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgId"
      values   = ["${var.organization_id}"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${data.aws_partition.current.partition}:iam::*:role/${var.assume_role}"]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgId"
      values   = ["${var.organization_id}"]
    }
  }

  # statement {
  #   effect    = "Allow"
  #   actions   = ["sns:Publish"]
  #   resources = [module.guardduty_enabler_topic.arn]
  # }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${var.control_tower_management_account}:log-group:/aws/lambda/*"]
  }

  # # statement {
  # #   effect    = "Allow"
  # #   actions   = ["CloudFormation:ListStackInstances"]
  # #   resources = ["arn:${data.aws_partition.current.partition}:cloudformation:${data.aws_region.current.name}:${var.control_tower_management_account}:stackset/AWSControlTowerBP-BASELINE-CLOUDWATCH:*"]
  # # }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:CreateServiceLinkedRole",
    ]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:${data.aws_partition.current.partition}:iam::*:role/${var.assume_role}"]
  }

  statement {
    effect = "Allow"
    actions = [
      "guardduty:acceptinvitation",
      "guardduty:createdetector",
      "guardduty:createmembers",
      "guardduty:getdetector",
      "guardduty:invitemembers",
      "guardduty:listdetectors",
      "guardduty:listmembers",
      "guardduty:listinvitations",
      "guardduty:updatedetector",
    ]
    resources = ["*"]
  }
}


# Create Lambda Function for GuardDuty Enabler
module "lambda_enable_guardduty" {
  source                            = "git@github.com:clouddrove/terraform-aws-lambda?ref=feat/issue_276_a"
  depends_on                        = [module.iam-role]
  cloudwatch_logs_retention_in_days = 7
  create_iam_role                   = false
  subnet_ids                        = null
  name                              = var.name
  environment                       = var.environment
  enable                            = var.enable
  runtime                           = var.runtime
  handler                           = var.handler
  filename                          = var.filename
  create_layers                     = var.create_layers
  iam_role_arn                      = module.iam-role.arn
  reserved_concurrent_executions    = null
  variables = {
    assume_role     = var.assume_role
    region_filter   = var.region_filter
    ct_root_account = var.control_tower_management_account
    admin_account   = var.security_account_id
    topic           = "test-guarddutyenablertopic"
    log_level       = "ERROR"
  }

  # lambda permission
  actions     = var.actions
  principals  = var.principals
  source_arns = [module.guardduty_enabler_topic.id, aws_cloudwatch_event_rule.life_cycle_rule_guardduty.arn, aws_cloudwatch_event_rule.schedule_rule_guardduty.arn]
}

# Create SNS Topic for GuardDuty Enabler and  Subscribe Lambda to it
module "guardduty_enabler_topic" {
  source  = "clouddrove/sns/aws"
  version = "1.3.0"

  name         = var.sns_name
  environment  = var.environment
  enabled      = var.enabled
  enable_sns   = var.enable_sns
  enable_topic = var.enable_topic
  display_name = var.display_name
  topic_name   = var.topic_name

  # subscription    
  enable_subscription = var.enable_subscription
  endpoint            = module.lambda_enable_guardduty.arn
  protocol            = var.protocol
}

# Create Lifecycle Rule for GuardDuty
resource "aws_cloudwatch_event_rule" "life_cycle_rule_guardduty" {
  name        = "amazon-guardduty-lifecycle"
  description = "Amazon GuardDuty LifeCycle Trigger"

  event_pattern = jsonencode({
    source      = ["aws.controltower"],
    detail_type = ["AWS Service Event via CloudTrail"],
    detail = {
      eventName = ["CreateManagedAccount"]
    }
  })

  is_enabled = true
}

resource "aws_cloudwatch_event_target" "lambda_target_lifecycle" {
  rule      = aws_cloudwatch_event_rule.life_cycle_rule_guardduty.name
  target_id = "DailyInvite"
  arn       = module.lambda_enable_guardduty.arn
}

# Create Scheduled Rule for GuardDuty
resource "aws_cloudwatch_event_rule" "schedule_rule_guardduty" {
  name                = "amazon-guardduty-schedule-compliance"
  description         = "Amazon GuardDuty Schedule Compliance Trigger"
  schedule_expression = "rate(${var.compliance_frequency} minutes)"

  is_enabled = true
}

resource "aws_cloudwatch_event_target" "lambda_target_schedule" {
  rule      = aws_cloudwatch_event_rule.schedule_rule_guardduty.name
  target_id = "DailyInvite"
  arn       = module.lambda_enable_guardduty.arn
}