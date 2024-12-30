output "api_management_additional_location" {
  description = "Map listing gateway_regional_url and public_ip_addresses associated"
  value       = azurerm_api_management.apim.additional_location
}

output "api_management_gateway_regional_url" {
  description = "The Region URL for the Gateway of the API Management Service"
  value       = azurerm_api_management.apim.gateway_regional_url
}

output "api_management_gateway_url" {
  description = "The URL of the Gateway for the API Management Service"
  value       = azurerm_api_management.apim.gateway_url
}

output "api_management_id" {
  description = "The ID of the API Management Service"
  value       = azurerm_api_management.apim.id
}

output "api_management_identity" {
  description = "The identity of the API Management"
  value       = azurerm_api_management.apim.identity[0].principal_id
}

output "api_management_management_api_url" {
  description = "The URL for the Management API associated with this API Management service"
  value       = azurerm_api_management.apim.management_api_url
}

output "api_management_name" {
  description = "The name of the API Management Service"
  value       = azurerm_api_management.apim.name
}

output "api_management_portal_url" {
  description = "The URL for the Publisher Portal associated with this API Management service"
  value       = azurerm_api_management.apim.portal_url
}

output "api_management_private_ip_addresses" {
  description = "The Private IP addresses of the API Management Service"
  value       = azurerm_api_management.apim.private_ip_addresses
}

output "api_management_public_ip_addresses" {
  description = "The Public IP addresses of the API Management Service"
  value       = azurerm_api_management.apim.public_ip_addresses
}

output "api_management_scm_url" {
  description = "The URL for the SCM Endpoint associated with this API Management service"
  value       = azurerm_api_management.apim.scm_url
}
