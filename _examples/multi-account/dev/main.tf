# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
locals {}

#VPC
#Transit
#KMS (multi region)
#ACM ()
#Route53 dev.xyz.ca
#SecurtyBaseline
#Cloudtrail
#GuardDuty
#SecutyHub
#GuardRails

#EKS
#RDS
#EFS
#EBS Encryption

locals {
  name        = "ct"
  environment = "dev"
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

  cidr_block  = "10.0.20.0/16"
  subnet_type = private

}
