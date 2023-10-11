provider "aws" {
  region = "us-east-2"
}

module "guardduty" {
  source = "../"

  name                             = "guardduty"
  label_order                      = ["name", "environment"]
  organization_id                  = ""
  security_account_id              = ""
  control_tower_management_account = ""
}

resource "aws_guardduty_organization_admin_account" "this" {
  depends_on       = [module.guardduty]
  admin_account_id = "" #Add Security Account ID here.
}