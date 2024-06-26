## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acm\_enable | Whether or not to enable the entire ACM module or not. | `bool` | `true` | no |
| aws\_github\_oidc\_role\_enable | Create aws oidc GitHUb role or not | `bool` | `false` | no |
| cidr\_block | CIDR for the VPC. | `string` | `"10.10.0.0/16"` | no |
| create\_flow\_log\_cloudwatch\_iam\_role | Flag to be set true when cloudwatch iam role is to be created when flow log destination type is set to cloudwatch logs. | `bool` | `true` | no |
| domain | A domain name for which the certificate should be issued. | `string` | `""` | no |
| enable\_flow\_log | Enable vpc\_flow\_log logs. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| flow\_log\_destination\_arn | ARN of destination where vpc flow logs are to stored. Can be of existing s3 or existing cloudwatch log group. | `string` | `null` | no |
| flow\_log\_destination\_type | Type of flow log destination. Can be `s3` or `cloud-watch-logs` | `string` | `"s3"` | no |
| flow\_log\_retention\_period | Specifies the number of days you want to retain log events in the specified log group for VPC flow logs | `number` | `null` | no |
| label\_order | Label order, e.g. `name`,`environment`. | `list(string)` | <pre>[<br>  "environment",<br>  "name"<br>]</pre> | no |
| managedby | Managed by for tags | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| nat\_gateway\_enabled | Flag to enable/disable NAT Gateways creation in public subnets. | `bool` | `false` | no |
| oidc\_github\_repos | GitHub repository names for access | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| oidc\_provider\_exists | Mention oidc provider exist or not in true or false | `bool` | `false` | no |
| policy\_arns | A list of ARNs of policies to attach to the IAM role. | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/AdministratorAccess"<br>]</pre> | no |
| private\_enabled | Whether to create private Route53 zone. | `bool` | `false` | no |
| private\_inbound\_acl\_rules | Private subnets inbound network ACLs | `any` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| private\_outbound\_acl\_rules | Private subnets outbound network ACLs | `any` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| provider\_url | URL for the OIDC provider | `string` | `"https://token.actions.githubusercontent.com"` | no |
| public\_enabled | Whether to create public Route53 zone. | `bool` | `true` | no |
| public\_inbound\_acl\_rules | Public subnets inbound network ACLs | `any` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| public\_outbound\_acl\_rules | Public subnets outbound network ACLs | `any` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| record\_enabled | Whether to create Route53 record set. | `bool` | `true` | no |
| records | List of objects of DNS records | `any` | `[]` | no |
| records\_force\_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `true` | no |
| region | Region (e.g. `us-east-1`, `us-east-2`, `ap-south-1`) | `string` | `""` | no |
| repository | Repository name for tags | `string` | `"https://github.com/clouddrove/terraform-aws-control-tower.git"` | no |
| role\_name | Name of the AWS IAM Role to create | `string` | `"github-oidc-terraform-role"` | no |
| route53\_enable | Enable Route53 to create or not. | `bool` | `true` | no |
| saml\_arn | The ARN of the IAM SAML identity provider. | `string` | `""` | no |
| self\_saml\_arn | The ARN of the IAM SAML identity provider for the self service portal. | `string` | `""` | no |
| sg\_enable | Whether or not to enable the entire SECURITY-GROUP module. | `bool` | `true` | no |
| single\_nat\_gateway | Enable for only single NAT Gateway in one Availability Zone | `bool` | `false` | no |
| split\_tunnel\_enable | Indicates whether split-tunnel is enabled on VPN endpoint. | `bool` | `false` | no |
| ssh\_allow\_ip | List of IP's to allowed for http\_https traffic | `string` | `""` | no |
| subject\_alternative\_names | Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation. | `list(any)` | `[]` | no |
| subnet\_enable | Enable subnet to create or not. | `bool` | `true` | no |
| subnet\_type | Type of subnets to create (`private`, `public` or `public-private` ). | `string` | `""` | no |
| tgw\_hub\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable. | `string` | `"enable"` | no |
| tgw\_hub\_create | Whether or not to create a Transit Gateway. | `bool` | `true` | no |
| tgw\_hub\_description | Description of the Hub Transit Gateway | `string` | `"This transit gateway hub is created for centerlised vpc peering"` | no |
| tgw\_hub\_destination\_cidr | The destination CIDR block (VPC). | `list(any)` | `[]` | no |
| tgw\_hub\_enable | Enable subnet to create or not. | `bool` | `false` | no |
| tgw\_hub\_resource\_share\_account\_ids | Ids of the account where the Transit Gateway should be shared. | `list(any)` | `[]` | no |
| tgw\_hub\_resource\_share\_allow\_external\_principals | Whether or not to allow external principals for the Resource Share for the Transit Gateway. | `bool` | `true` | no |
| tgw\_hub\_resource\_share\_enable | Whether or not to create a Resource Share for the Transit Gateway. | `bool` | `true` | no |
| tgw\_hub\_transit\_gateway\_default\_route\_table\_association | Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true. | `bool` | `true` | no |
| tgw\_hub\_transit\_gateway\_default\_route\_table\_propagation | Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true. | `bool` | `true` | no |
| tgw\_spoke\_aws\_ram\_resource\_share\_accepter | Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable. | `bool` | `true` | no |
| tgw\_spoke\_create | Whether or not to create a Transit Gateway. | `bool` | `false` | no |
| tgw\_spoke\_description | Description of the Spoke Transit Gateway | `string` | `"This transit gateway spoke is created for centerlised vpc peering"` | no |
| tgw\_spoke\_destination\_cidr | The destination CIDR block (VPC 1). | `list(any)` | `[]` | no |
| tgw\_spoke\_enable | Enable subnet to create or not. | `bool` | `false` | no |
| tgw\_spoke\_resource\_share\_arn | Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable. | `string` | `""` | no |
| tgw\_spoke\_transit\_gateway\_default\_route\_table\_association | Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true. | `bool` | `true` | no |
| tgw\_spoke\_transit\_gateway\_default\_route\_table\_propagation | Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true. | `bool` | `true` | no |
| tgw\_spoke\_transit\_gateway\_id | The ID of gateway id. | `string` | `null` | no |
| validation\_method | Which method to use for validation, DNS or EMAIL. | `string` | `"DNS"` | no |
| vpc\_enable | Enable vpc to create or not. | `bool` | `true` | no |
| vpn\_authentication\_type | The type of client authentication to be used. Valid values are `federated-authentication` , `certificate-authentication` | `string` | `"certificate-authentication"` | no |
| vpn\_cidr\_block | Client VPN CIDR | `string` | `""` | no |
| vpn\_enable | Enable vpn to create or not. | `bool` | `false` | no |
| vpn\_network\_cidr | Client Network CIDR | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| vpn\_organization\_name | Name of organization to use in private certificate | `string` | `"clouddrove.ca"` | no |
| vpn\_route\_cidr | Client Route CIDR | `list(any)` | <pre>[<br>  "0.0.0.0/0",<br>  "0.0.0.0/0",<br>  "0.0.0.0/0"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| acm\_arn | The ARN of the Certificate. |
| acm\_certificate\_domain\_validation\_options | A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| acm\_certificate\_status | Status of the certificate. |
| arn | Amazon Resource Name (ARN) of VPC |
| cert | A mapping of tags to assign to the certificate. |
| id | The ID of the Certificate. |
| igw\_id | The ID of the Internet Gateway. |
| ipv6\_cidr\_block | The IPv6 CIDR block. |
| ipv6\_cidr\_block\_network\_border\_group | The IPv6 Network Border Group Zone name |
| ipv6\_egress\_only\_igw\_id | The ID of the egress-only Internet Gateway |
| key | A mapping of tags to assign to the key. |
| prefix\_list\_id | The ID of the prefix list. |
| private\_acl | The ID of the network ACL. |
| private\_route\_tables\_id | The ID of the routing table. |
| private\_subnet\_cidrs | CIDR blocks of the created private subnets. |
| private\_subnet\_cidrs\_ipv6 | CIDR blocks of the created private subnets. |
| private\_subnet\_id | The ID of the private subnet. |
| private\_tags | A mapping of private tags to assign to the resource. |
| public\_acl | The ID of the network ACL. |
| public\_route\_tables\_id | The ID of the routing table. |
| public\_subnet\_cidrs | CIDR blocks of the created public subnets. |
| public\_subnet\_cidrs\_ipv6 | CIDR blocks of the created public subnets. |
| public\_subnet\_id | The ID of the subnet. |
| public\_tags | A mapping of public tags to assign to the resource. |
| security\_group\_arn | IDs on the AWS Security Groups associated with the instance. |
| security\_group\_id | IDs on the AWS Security Groups associated with the instance. |
| security\_group\_tags | A mapping of public tags to assign to the resource. |
| sg\_id | The ID of the SG for Client VPN. |
| tgw\_hub\_ec2\_transit\_gateway\_arn | EC2 Transit Gateway Amazon Resource Name (ARN) |
| tgw\_hub\_ec2\_transit\_gateway\_association\_default\_route\_table\_id | Identifier of the default association route table |
| tgw\_hub\_ec2\_transit\_gateway\_owner\_id | Identifier of the AWS account that owns the EC2 Transit Gateway |
| tgw\_hub\_ec2\_transit\_gateway\_propagation\_default\_route\_table\_id | Identifier of the default propagation route table |
| tgw\_hub\_ec2\_transit\_gateway\_route\_table\_id | EC2 Transit Gateway Route Table identifier |
| tgw\_hub\_ec2\_transit\_gateway\_vpc\_attachment | Map of EC2 Transit Gateway VPC Attachment attributes |
| tgw\_hub\_ec2\_transit\_gateway\_vpc\_attachment\_ids | List of EC2 Transit Gateway VPC Attachment identifiers |
| tgw\_hub\_ram\_principal\_association\_id | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma |
| tgw\_hub\_ram\_resource\_share\_id | The Amazon Resource Name (ARN) of the resource share |
| tgw\_hub\_resource\_share\_arn | The ARN  of the RAM. |
| tgw\_hub\_transit\_gateway\_id | The ID of the Transit Gateway. |
| tgw\_spoke\_ec2\_transit\_gateway\_arn | EC2 Transit Gateway Amazon Resource Name (ARN) |
| tgw\_spoke\_ec2\_transit\_gateway\_association\_default\_route\_table\_id | Identifier of the default association route table |
| tgw\_spoke\_ec2\_transit\_gateway\_owner\_id | Identifier of the AWS account that owns the EC2 Transit Gateway |
| tgw\_spoke\_ec2\_transit\_gateway\_propagation\_default\_route\_table\_id | Identifier of the default propagation route table |
| tgw\_spoke\_ec2\_transit\_gateway\_route\_table\_id | EC2 Transit Gateway Route Table identifier |
| tgw\_spoke\_ec2\_transit\_gateway\_vpc\_attachment | Map of EC2 Transit Gateway VPC Attachment attributes |
| tgw\_spoke\_ec2\_transit\_gateway\_vpc\_attachment\_ids | List of EC2 Transit Gateway VPC Attachment identifiers |
| tgw\_spoke\_ram\_principal\_association\_id | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma |
| tgw\_spoke\_ram\_resource\_share\_id | The Amazon Resource Name (ARN) of the resource share |
| tgw\_spoke\_resource\_share\_arn | The ARN  of the RAM. |
| tgw\_spoke\_transit\_gateway\_id | The ID of the Transit Gateway. |
| validation\_route53\_record\_fqdns | List of FQDNs built using the zone domain and name. |
| vpc\_arn | The ARN of the VPC |
| vpc\_cidr\_block | The CIDR block of the VPC. |
| vpc\_default\_network\_acl\_id | The ID of the network ACL created by default on VPC creation. |
| vpc\_default\_route\_table\_id | The ID of the route table created by default on VPC creation. |
| vpc\_default\_security\_group\_id | The ID of the security group created by default on VPC creation. |
| vpc\_id | The ID of the VPC. |
| vpc\_ipv6\_association\_id | The association ID for the IPv6 CIDR block. |
| vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC. |
| vpn\_arn | The ARN of the Client VPN endpoint. |
| vpn\_dns\_name | VPN DNS name |
| vpn\_id | The ID of the Client VPN endpoint. |
| zone\_id | The Hosted Zone ID. This can be referenced by zone records. |

