# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "transit_gateway_id" {
  value       = module.CT.transit_gateway_id
  description = "The ID of the Transit Gateway."
}

output "resource_share_arn" {
  value       = module.CT.resource_share_arn
  description = "The ARN  of the RAM."
}

output "vpn_id" {
  value       = module.CT.vpn_id
  description = "The ID of the Client VPN endpoint."
}