resource "azurerm_role_assignment" "rbac" {
  for_each = { for idx, val in local.flattened_role_assignments : "${val.role}-${val.principal}" => val }

  principal_id         = each.value.principal
  scope                = data.azurerm_resource_group.func_rg.id
  role_definition_name = each.value.role
}

resource "azurerm_role_assignment" "cosmos" {
  for_each = var.function_app_settings.cosmosdb_account_name != null ? toset(var.cosmos_role_definition) : []

  principal_id         = azurerm_windows_function_app.windows_function.identity[0].principal_id
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, module.cosmosdb_account_naming[0].resource_group.name)
  role_definition_name = each.key
}

resource "azurerm_role_assignment" "storage" {
  for_each = var.storage_uses_managed_identity ? toset(["Storage Account Contributor", "Storage Blob Data Contributor"]) : []

  principal_id         = azurerm_windows_function_app.windows_function.identity[0].principal_id
  scope                = module.storage.azurerm_storage_account_id
  role_definition_name = each.key
}
