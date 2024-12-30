# Assign Permissions to the Managed Identity for Key Vault Access
resource "azurerm_role_assignment" "appgw_kv_role_assignment" {
  principal_id         = azurerm_user_assigned_identity.appgw_identity.principal_id
  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
}