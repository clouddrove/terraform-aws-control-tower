data "aws_caller_identity" "current" {}

locals {
#   account_id = data.aws_caller_identity.current.account_id
  tags = {
    "name"        = var.name
    "repository"  = var.repository
    "environment" = var.environment
    "managedby"   = var.managedby
  }
}

data "tls_certificate" "github" {
  count = var.enable ? 1 : 0
  url   = var.url
}

resource "aws_iam_openid_connect_provider" "github" {
  count           = var.enable ? 1 : 0
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github[0].certificates[0].sha1_fingerprint]
  url             = var.url
  tags            = local.tags
}

# Include the role resource and attachment here

resource "aws_iam_role" "github" {
  count              = var.enable ? 1 : 0
  name               = var.role_name
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.github[0].arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:${var.github_repo}:*"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "github" {
  count      = var.enable ? 1 : 0
  role       = aws_iam_role.github[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

