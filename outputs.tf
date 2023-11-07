# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
# ---------------------------------VPC------------------------------------------
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC."
}

output "vpc_arn" {
  value       = module.vpc.vpc_arn
  description = "The ARN of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC."
}

output "ipv6_cidr_block" {
  value       = module.vpc.ipv6_cidr_block
  description = "The IPv6 CIDR block."
}

output "vpc_ipv6_association_id" {
  value       = module.vpc.vpc_ipv6_association_id
  description = "The association ID for the IPv6 CIDR block."
}

output "ipv6_cidr_block_network_border_group" {
  value       = module.vpc.ipv6_cidr_block_network_border_group
  description = "The IPv6 Network Border Group Zone name"
}

output "vpc_main_route_table_id" {
  value       = module.vpc.vpc_main_route_table_id
  description = "The ID of the main route table associated with this VPC."
}

output "vpc_default_network_acl_id" {
  value       = module.vpc.vpc_default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = module.vpc.vpc_default_security_group_id
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = module.vpc.vpc_default_route_table_id
  description = "The ID of the route table created by default on VPC creation."
}

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the Internet Gateway."
}

output "ipv6_egress_only_igw_id" {
  value       = module.vpc.ipv6_egress_only_igw_id
  description = "The ID of the egress-only Internet Gateway"
}

output "arn" {
  value       = module.vpc.arn
  description = "Amazon Resource Name (ARN) of VPC"
}

# ---------------------------------SUBNET---------------------------------------
output "public_subnet_id" {
  value       = module.subnet.public_subnet_id
  description = "The ID of the subnet."
}

output "public_subnet_cidrs" {
  value       = module.subnet.public_subnet_cidrs
  description = "CIDR blocks of the created public subnets."
}

output "public_subnet_cidrs_ipv6" {
  value       = module.subnet.public_subnet_cidrs_ipv6
  description = "CIDR blocks of the created public subnets."
}

output "private_subnet_id" {
  value       = module.subnet.private_subnet_id
  description = "The ID of the private subnet."
}

output "private_subnet_cidrs" {
  value       = module.subnet.private_subnet_cidrs
  description = "CIDR blocks of the created private subnets."
}

output "private_subnet_cidrs_ipv6" {
  value       = module.subnet.private_subnet_cidrs_ipv6
  description = "CIDR blocks of the created private subnets."
}

output "public_route_tables_id" {
  value       = module.subnet.public_route_tables_id
  description = "The ID of the routing table."
}

output "private_route_tables_id" {
  value       = module.subnet.private_route_tables_id
  description = "The ID of the routing table."
}

output "private_tags" {
  value       = module.subnet.private_tags
  description = "A mapping of private tags to assign to the resource."
}

output "public_tags" {
  value       = module.subnet.public_tags
  description = "A mapping of public tags to assign to the resource."
}

output "public_acl" {
  value       = module.subnet.public_acl
  description = "The ID of the network ACL."
}

output "private_acl" {
  value       = module.subnet.private_acl
  description = "The ID of the network ACL."
}

# ---------------------------------SECURITY-GROUP-------------------------------
output "prefix_list_id" {
  value       = module.ssh.prefix_list_id
  description = "The ID of the prefix list."
}

output "security_group_id" {
  value       = module.ssh.security_group_id
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "security_group_arn" {
  value       = module.ssh.security_group_arn
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "security_group_tags" {
  value       = module.ssh.security_group_tags
  description = "A mapping of public tags to assign to the resource."
}
# ---------------------------------TRANSIT-GATEWAY------------------------------
##---------
# tgw_hub
##---------
output "tgw_hub_transit_gateway_id" {
  value       = module.tgw_hub.transit_gateway_id
  description = "The ID of the Transit Gateway."
}

output "tgw_hub_resource_share_arn" {
  value       = module.tgw_hub.resource_share_arn
  description = "The ARN  of the RAM."
}

output "tgw_hub_ec2_transit_gateway_arn" {
  value       = module.tgw_hub.ec2_transit_gateway_arn
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)"
}

output "tgw_hub_ec2_transit_gateway_route_table_id" {
  value       = module.tgw_hub.ec2_transit_gateway_route_table_id
  description = "EC2 Transit Gateway Route Table identifier"
}

output "tgw_hub_ec2_transit_gateway_vpc_attachment" {
  value       = module.tgw_hub.ec2_transit_gateway_vpc_attachment
  description = "Map of EC2 Transit Gateway VPC Attachment attributes"
}

output "tgw_hub_ram_resource_share_id" {
  value       = module.tgw_hub.ram_resource_share_id
  description = "The Amazon Resource Name (ARN) of the resource share"
}

output "tgw_hub_ec2_transit_gateway_association_default_route_table_id" {
  value       = module.tgw_hub.ec2_transit_gateway_association_default_route_table_id
  description = "Identifier of the default association route table"
}

output "tgw_hub_ec2_transit_gateway_propagation_default_route_table_id" {
  value       = module.tgw_hub.ec2_transit_gateway_propagation_default_route_table_id
  description = "Identifier of the default propagation route table"
}

output "tgw_hub_ec2_transit_gateway_vpc_attachment_ids" {
  value       = module.tgw_hub.ec2_transit_gateway_vpc_attachment_ids
  description = "List of EC2 Transit Gateway VPC Attachment identifiers"
}

output "tgw_hub_ram_principal_association_id" {
  value       = module.tgw_hub.ram_principal_association_id
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma"
}

output "tgw_hub_ec2_transit_gateway_owner_id" {
  value       = module.tgw_hub.ec2_transit_gateway_owner_id
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway"
}
##----------
# tgw_spoke
##----------
output "tgw_spoke_transit_gateway_id" {
  value       = module.tgw_spoke.transit_gateway_id
  description = "The ID of the Transit Gateway."
}

output "tgw_spoke_resource_share_arn" {
  value       = module.tgw_spoke.resource_share_arn
  description = "The ARN  of the RAM."
}

output "tgw_spoke_ec2_transit_gateway_arn" {
  value       = module.tgw_spoke.ec2_transit_gateway_arn
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)"
}

output "tgw_spoke_ec2_transit_gateway_route_table_id" {
  value       = module.tgw_spoke.ec2_transit_gateway_route_table_id
  description = "EC2 Transit Gateway Route Table identifier"
}

output "tgw_spoke_ec2_transit_gateway_vpc_attachment" {
  value       = module.tgw_spoke.ec2_transit_gateway_vpc_attachment
  description = "Map of EC2 Transit Gateway VPC Attachment attributes"
}

output "tgw_spoke_ram_resource_share_id" {
  value       = module.tgw_spoke.ram_resource_share_id
  description = "The Amazon Resource Name (ARN) of the resource share"
}

output "tgw_spoke_ec2_transit_gateway_association_default_route_table_id" {
  value       = module.tgw_spoke.ec2_transit_gateway_association_default_route_table_id
  description = "Identifier of the default association route table"
}

output "tgw_spoke_ec2_transit_gateway_propagation_default_route_table_id" {
  value       = module.tgw_spoke.ec2_transit_gateway_propagation_default_route_table_id
  description = "Identifier of the default propagation route table"
}

output "tgw_spoke_ec2_transit_gateway_vpc_attachment_ids" {
  value       = module.tgw_spoke.ec2_transit_gateway_vpc_attachment_ids
  description = "List of EC2 Transit Gateway VPC Attachment identifiers"
}

output "tgw_spoke_ram_principal_association_id" {
  value       = module.tgw_spoke.ram_principal_association_id
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma"
}

output "tgw_spoke_ec2_transit_gateway_owner_id" {
  value       = module.tgw_spoke.ec2_transit_gateway_owner_id
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway"
}

# ---------------------------------ACM------------------------------------------
output "id" {
  value       = module.acm.id
  description = "The ID of the Certificate."
}

output "acm_arn" {
  value       = module.acm.arn
  description = "The ARN of the Certificate."
}

output "acm_certificate_domain_validation_options" {
  value       = module.acm.acm_certificate_domain_validation_options
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
}

output "acm_certificate_status" {
  value       = module.acm.acm_certificate_status
  description = "Status of the certificate."
}

output "validation_route53_record_fqdns" {
  value       = module.acm.validation_route53_record_fqdns
  description = "List of FQDNs built using the zone domain and name."
}

# ---------------------------------ROUTE-53-------------------------------------
output "zone_id" {
  value       = module.route53.zone_id
  description = "The Hosted Zone ID. This can be referenced by zone records."
}

# ---------------------------------CLIENT-VPN-----------------------------------
output "key" {
  value       = module.vpn.key
  description = "A mapping of tags to assign to the key."
  sensitive   = true
}

output "cert" {
  value       = module.vpn.cert
  description = "A mapping of tags to assign to the certificate."
  sensitive   = true
}

output "sg_id" {
  value       = module.vpn.sg_id
  description = "The ID of the SG for Client VPN."
}

output "vpn_id" {
  value       = module.vpn.vpn_id
  description = "The ID of the Client VPN endpoint."
}

output "vpn_arn" {
  value       = module.vpn.vpn_arn
  description = "The ARN of the Client VPN endpoint."
}

output "vpn_dns_name" {
  value       = module.vpn.vpn_dns_name
  description = "VPN DNS name"
}