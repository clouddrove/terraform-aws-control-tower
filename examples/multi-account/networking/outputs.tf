# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "transit_gateway_id" {
  value       = module.control_tower.tgw_hub_transit_gateway_id
  description = "The ID of the Transit Gateway."
}

output "resource_share_arn" {
  value       = module.control_tower.tgw_hub_resource_share_arn
  description = "The ARN  of the RAM."
}

output "vpn_id" {
  value       = module.control_tower.vpn_id
  description = "The ID of the Client VPN endpoint."
}