output "key_vault_name" {
  description = "The name of Keyvault"
  value       = module.naming.key_vault.name
}

output "key_vault_rg" {
  description = "The resouce Group Name where keyvault is created"
  value       = data.azurerm_resource_group.keyvault.name
}

output "keys_resource_ids" {
  description = "A map of key keys to resource ids."
  value       = module.azure_keyvault.keys_resource_ids
}

output "private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = module.azure_keyvault.private_endpoints
}

output "resource_id" {
  description = "The Azure resource id of the key vault."
  value       = module.azure_keyvault.resource_id
}

output "secrets_resource_ids" {
  description = "A map of secret keys to resource ids."
  value       = module.azure_keyvault.secrets_resource_ids
}

output "uri" {
  description = "The URI of the vault for performing operations on keys and secrets"
  value       = module.azure_keyvault.uri
}
