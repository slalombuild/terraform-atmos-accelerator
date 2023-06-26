output "key_vault_id" {
  description = "ID of the Key Vault."
  value       = azurerm_key_vault.default.id
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = azurerm_key_vault.default.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.default.vault_uri
}
