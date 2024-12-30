output "azurerm_resource_group_name" {
  description = "The name of the storage resource group"
  value       = local.resource_group_name
}

output "azurerm_storage_account_id" {
  description = "The id of the storage account"
  value       = module.avm-res-storage-storageaccount.resource_id
}

output "azurerm_storage_account_name" {
  description = "The name of the storage account"
  value       = module.avm-res-storage-storageaccount.name
}

output "azurerm_storage_account_resource" {
  description = "The storage account resource object"
  sensitive   = true
  value       = module.avm-res-storage-storageaccount.resource
}

output "azurerm_storage_containers_names" {
  description = "List of storage container names created by the storage account module."
  value       = [for container in module.avm-res-storage-storageaccount.containers : container.name]
}

output "storage_account_queues" {
  description = "Map of storage storage queues that are created."
  value       = module.avm-res-storage-storageaccount.queues
}

output "storage_account_shares" {
  description = "Map of storage storage shares that are created."
  value       = module.avm-res-storage-storageaccount.shares
}

output "storage_account_tables" {
  description = "Map of storage storage tables that are created."
  value       = module.avm-res-storage-storageaccount.tables
}
