module "inputs" {
  count                 = module.this.enabled && var.key_vault_name != null && local.create_cosmosdb_account ? 1 : 0
  source                = "../outputs"
  namespace             = module.this.namespace
  environment           = module.this.environment
  key_vault_name        = var.key_vault_name
  key_vault_secret_name = module.naming.cosmosdb_account.name
  keyvault_inputs = {
    name                            = module.naming.cosmosdb_account.name
    id                              = azurerm_cosmosdb_account.cs_db[0].id
    resource_group_name             = data.azurerm_resource_group.cs_rg.name
    endpoint                        = azurerm_cosmosdb_account.cs_db[0].endpoint
    primary_key                     = azurerm_cosmosdb_account.cs_db[0].primary_key
    primary_sql_connection_string   = azurerm_cosmosdb_account.cs_db[0].secondary_sql_connection_string
    secondary_key                   = azurerm_cosmosdb_account.cs_db[0].primary_key
    secondary_sql_connection_string = azurerm_cosmosdb_account.cs_db[0].secondary_sql_connection_string
    principal_id                    = try(azurerm_cosmosdb_account.cs_db[0].identity[0].principal_id, null)
    sql_database_name               = var.create_cosmosdb_sql_database || var.create_cosmosdb_sql_container ? "${module.naming.cosmosdb_account.name}-sql-db" : null
    sql_conatiners = var.create_cosmosdb_sql_container ? { for i, container in azurerm_cosmosdb_sql_container.sql : i => {
      name = container.name
      id   = container.id
    } } : {}
    cosmos_tables = var.create_cosmosdb_table ? { for i, table in azurerm_cosmosdb_table.ct : i => {
      name = table.name
      id   = table.id
    } } : {}
  }
}
