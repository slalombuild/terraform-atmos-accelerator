output "container_names" {
  description = "Names of the CosmosDB SQL containers"
  value       = var.create_cosmosdb_sql_container ? [for container in azurerm_cosmosdb_sql_container.sql : container.name] : []
}

output "cosmosdb_account_name" {
  description = "The account name of CosmosDB"
  value       = local.create_cosmosdb_account ? module.naming.cosmosdb_account.name : module.cosmosdb_naming[0].cosmosdb_account.name
}

output "cosmosdb_rg_name" {
  description = "The CosmosDB resource group name"
  value       = data.azurerm_resource_group.cs_rg.name
}

output "cosmosdb_sql_db_name" {
  description = "The name of cosmos sql database"
  value       = var.create_cosmosdb_sql_database || var.create_cosmosdb_sql_container ? "${module.naming.cosmosdb_account.name}-sql-db" : null
}

output "endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value       = try(azurerm_cosmosdb_account.cs_db[0].endpoint, null)
}

output "id" {
  description = "The CosmosDB Account ID."
  value       = local.create_cosmosdb_account ? try(azurerm_cosmosdb_account.cs_db[0].id, null) : data.azurerm_cosmosdb_account.cosmos[0].id
}

output "primary_key" {
  description = "The Primary key for the CosmosDB Account"
  sensitive   = true
  value       = try(azurerm_cosmosdb_account.cs_db[0].primary_key, null)
}

output "primary_sql_connection_string" {
  description = "Primary SQL connection string for the CosmosDB Account."
  sensitive   = true
  value       = try(azurerm_cosmosdb_account.cs_db[0].primary_sql_connection_string, null)
}

output "principal_id" {
  description = "The Principal ID associated with this Managed Service Identity."
  value       = try(azurerm_cosmosdb_account.cs_db[0].identity[0].principal_id, null)
}

output "secondary_key" {
  description = "The Secondary key for the CosmosDB Account"
  sensitive   = true
  value       = try(azurerm_cosmosdb_account.cs_db[0].secondary_key, null)
}

output "secondary_sql_connection_string" {
  description = "Secondary SQL connection string for the CosmosDB Account."
  sensitive   = true
  value       = try(azurerm_cosmosdb_account.cs_db[0].secondary_sql_connection_string, null)
}

output "table_names" {
  description = "Names of the CosmosDB Tables"
  value       = var.create_cosmosdb_table ? [for table in azurerm_cosmosdb_table.ct : table.name] : []
}

output "tenant_id" {
  description = "The Tenant ID associated with this Managed Service Identity."
  value       = try(azurerm_cosmosdb_account.cs_db[0].identity[0].tenant_id, null)
}
