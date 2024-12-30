output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.tfstate.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account. This value is sensitive and masked from Terraform output."
  sensitive   = true
  value       = azurerm_storage_account.tfstate.primary_access_key
}

output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.tfstate.primary_blob_endpoint
}

output "storage_account_primary_location" {
  description = "The primary location of the storage account."
  value       = azurerm_storage_account.tfstate.primary_location
}

output "storage_container_has_immutability_policy" {
  description = "Is there an Immutability Policy configured on this Storage Container?"
  value       = azurerm_storage_container.tfstate.has_immutability_policy
}

output "storage_container_has_legal_hold" {
  description = "Is there a Legal Hold configured on this Storage Container?"
  value       = azurerm_storage_container.tfstate.has_legal_hold
}

output "storage_container_id" {
  description = "The ID of the Storage Container."
  value       = azurerm_storage_container.tfstate.id
}

output "storage_container_name" {
  description = "The name of the Storage Container."
  value       = azurerm_storage_container.tfstate.name
}

output "storage_container_resource_manager_id" {
  description = "The Resource Manager ID of this Storage Container."
  value       = azurerm_storage_container.tfstate.resource_manager_id
}
