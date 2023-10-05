# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "label_order" {
  value       = local.label_order
  description = "Label order."
}

output "transit_gateway_id" {
  value       = module.tgw_hub.transit_gateway_id
  description = "The ID of the Transit Gateway."
}

output "resource_share_arn" {
  value       = module.tgw_hub.resource_share_arn
  description = "The ARN  of the RAM."
}

output "vpn_id" {
  value       = module.vpn.vpn_id
  description = "The ID of the Client VPN endpoint."
}