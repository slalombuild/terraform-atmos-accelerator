output "application_gateway_id" {
  description = "The ID of the Azure Application Gateway."
  value       = module.application_gateway.application_gateway_id
}

output "application_gateway_name" {
  description = "The name of the Azure Application Gateway."
  value       = module.application_gateway.application_gateway_name
}

output "backend_address_pools" {
  description = "Information about the backend address pools configured for the Application Gateway, including their names."
  value       = module.application_gateway.backend_address_pools
}

output "backend_http_settings" {
  description = "Information about the backend HTTP settings for the Application Gateway, including settings like port and protocol."
  value       = module.application_gateway.backend_http_settings
}

output "frontend_port" {
  description = "Information about the frontend ports used by the Application Gateway, including their names and port numbers."
  value       = module.application_gateway.frontend_port
}

output "http_listeners" {
  description = "Information about the HTTP listeners configured for the Application Gateway, including their names and settings."
  value       = module.application_gateway.http_listeners
}

output "probes" {
  description = "Information about health probes configured for the Application Gateway, including their settings."
  value       = module.application_gateway.probes
}

output "public_ip_address" {
  description = "The actual public IP address associated with the Public IP resource."
  value       = module.application_gateway.public_ip_address
}

output "public_ip_id" {
  description = "The ID of the Azure Public IP address associated with the Application Gateway."
  value       = module.application_gateway.public_ip_id
}

output "request_routing_rules" {
  description = "Information about request routing rules defined for the Application Gateway, including their names and configurations."
  value       = module.application_gateway.request_routing_rules
}

output "resource_id" {
  description = "Resource ID of Container Group Instance"
  value       = module.application_gateway.resource_id
}

output "ssl_certificates" {
  description = "Information about SSL certificates used by the Application Gateway, including their names and other details."
  sensitive   = true
  value       = module.application_gateway.ssl_certificates
}

output "tags" {
  description = "The tags applied to the Application Gateway."
  value       = module.application_gateway.tags
}

output "waf_configuration" {
  description = "Information about the Web Application Firewall (WAF) configuration, if applicable."
  value       = module.application_gateway.waf_configuration
}
