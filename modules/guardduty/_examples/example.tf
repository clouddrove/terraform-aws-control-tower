provider "aws" {
  region = "us-east-1"
}

module "guardduty" {
  source = "../"

  name        = "guardduty"
  environment = "test"
  label_order = ["name", "environment"]

  organization_id      = ""
  security_account_id  = ""
}

