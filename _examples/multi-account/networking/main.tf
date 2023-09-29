# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
locals {}

#2 VPC (Dev & Prod)
#Transit
#KMS (multi region)
#ACM ()
#Route53 networking.identos.ca
#SecurtyBaseline
#Cloudtrail
#GuardDuty
#SecutyHub
#GuardRails
# VPN
# Bastion host

locals {
  name        = "ct"
  environment = "networking"
  region      = "us-east-1"
}

provider "aws" {
  region = local.region
}

# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
module "CT" {
  source      = "../../"
  name        = local.name
  environment = local.environment

  cidr_block  = "10.0.10.0/16"
  subnet_type = private

}
