output "frontdoor_custom_domain_id" {
  description = "The ID of the Front Door Custom Domain."
  value       = try([for i in azurerm_cdn_frontdoor_custom_domain.fd_custom_domain : i.id], null)
}

output "frontdoor_custom_domain_validation_token" {
  description = "Challenge used for DNS TXT record or file based validation."
  value       = try([for i in azurerm_cdn_frontdoor_custom_domain.fd_custom_domain : i.validation_token], null)
}

output "frontdoor_endpoint_hostname" {
  description = "The host name of the Front Door Endpoint, in the format {endpointName}.{dnsZone} (for example, contoso.azureedge.net)."
  value       = try([for i in azurerm_cdn_frontdoor_endpoint.fd_endpoint : i.host_name], null)
}

output "frontdoor_endpoint_id" {
  description = "The ID of this Front Door Endpoint"
  value       = try([for i in azurerm_cdn_frontdoor_endpoint.fd_endpoint : i.id], null)
}

output "frontdoor_origin_group_id" {
  description = "The ID of this Front origin group"
  value       = try([for i in azurerm_cdn_frontdoor_origin_group.fd_origin_group : i.id], null)
}

output "frontdoor_origin_id" {
  description = "The ID of this Front origin"
  value       = try([for i in azurerm_cdn_frontdoor_origin.fd_origin : i.id], null)
}

output "frontdoor_profile_id" {
  description = "The ID of this Front Door Profile"
  value       = azurerm_cdn_frontdoor_profile.fd_profile.id
}

output "frontdoor_profile_name" {
  description = "The name of this Front Door Profile"
  value       = module.naming.frontdoor.name
}

output "frontdoor_rg_name" {
  description = "The name of this Front Door resource group"
  value       = data.azurerm_resource_group.fd_rg.name
}

output "frontdoor_route_id" {
  description = "The ID of the Front Door Route."
  value       = try([for i in azurerm_cdn_frontdoor_route.fd_route : i.id], null)
}

output "frontdoor_rule_id" {
  description = "The ID of the Front Door Rule."
  value       = try([for i in azurerm_cdn_frontdoor_rule.fd_rules : i.id], null)
}

output "frontdoor_rule_set_id" {
  description = "The ID of the Front Door Rule Set."
  value       = try([for i in azurerm_cdn_frontdoor_rule_set.fd_rule_set : i.id], null)
}
