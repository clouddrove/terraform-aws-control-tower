# Terraform Configuration for AWS IAM GitHub OIDC Role

Creates an IAM role that trust the IAM GitHub OIDC provider.

## Prerequisites

Before using this configuration, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- Appropriate AWS credentials and permissions to create IAM resources.

## Example
```bash
  module "oidc" {
  source = "git@github.com:clouddrove/terraform-aws-control-tower?ref=master"

  # Module input variables
  vpn_enable       = false
  route53_enable   = false
  acm_enable       = false
  tgw_spoke_enable = false
  tgw_hub_enable   = false
  sg_enable        = false
  subnet_enable    = false
  vpc_enable       = false
  oidc_enable      = true
  url              = "https://token.actions.githubusercontent.com"
  github_repos     = ["username/reponame"]
  role_name        = "GitHub-Deploy-Role"
  name             = "app"
  repository       = "repository-name"
  environment      = "control-tower"
  managedby        = "hello@clouddrove.com"
}
```

4. Initialize the Terraform working directory:

   ```bash
   terraform init

5. Review the Terraform plan:

   ```bash
   terraform plan

5. Apply the configuration to create the AWS resources:

   ```bash
   terraform apply

6. Confirm the changes by typing yes when prompted.
7. The configuration will create the specified IAM Role and OpenID Connect Provider. If var.enable is set to true, it will also attach the AdministratorAccess policy to the IAM Role.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| oidc_enable | Whether to create AWS oidc GitHUb role or not. | `bool` | false | yes |
| role_name  | Role name . | `string` | `GitHub-Deploy-Role` | yes |
| github_repos   | GitHub repository to set IAM Role conditions . | `list(string)` | `""` | yes |
| url | URL for the OIDC provider. | `string` | `https://token.actions.githubusercontent.com` | yes |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | yes |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | yes |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | yes |
| repository | repsoitory name | `string` | `""` | yes |

## Cleanup
1. To destroy the created resources, run:
   ```bash
   terraform destroy
   
2. Confirm the destruction by typing yes when prompted.
