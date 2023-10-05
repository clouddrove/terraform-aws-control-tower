provider "aws" {
  region = "us-east-2"
}

module "guardduty" {
  source = "../"

  name                             = "guardduty"
  environment                      = "test"
  label_order                      = ["name", "environment"]
  organization_id                  = ""
  security_account_id              = ""
  control_tower_management_account = ""
}

