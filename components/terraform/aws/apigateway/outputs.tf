output "id" {
  description = "The ID of the API Gateway"
  value       = module.api_gateway.id
}

output "invoke_url" {
  description = "The URL to invoke the REST API"
  value       = module.api_gateway.invoke_url
}
