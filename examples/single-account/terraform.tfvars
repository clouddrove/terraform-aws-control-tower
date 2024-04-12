enable_flow_log            = true
flow_log_destination_type  = "cloud-watch-logs"
subnet_type                = "public-private"
domain                     = "clouddrove.ca"
records                    = []
hub_destination_cidr       = ["10.11.0.0/16"]
vpn_cidr_block             = "172.16.0.0/16"
resource_share_account_ids = ["540158961549"]

####AWS-OIDC-GITHUB-ROLE######

oidc_github_repos    = ["clouddrove/terraform-aws-control-tower"]
role_name            = "github-oidc-terraform-role"
policy_arns          = ["arn:aws:iam::aws:policy/AdministratorAccess"]
oidc_provider_exists = false

