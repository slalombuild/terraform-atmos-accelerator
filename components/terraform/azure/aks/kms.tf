resource "azurerm_key_vault_key" "kms" {
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  key_type        = "RSA"
  key_vault_id    = azurerm_key_vault.des_vault.id
  name            = format("etcd-encryption-%s", module.naming.key_vault_key.name_unique)
  expiration_date = timeadd("${formatdate("YYYY-MM-DD", timestamp())}T00:00:00Z", "168h")
  key_size        = 2048

  depends_on = [
    azurerm_key_vault_access_policy.current_user
  ]

  lifecycle {
    ignore_changes = [expiration_date]
  }

  tags = var.default_tags
}

resource "azurerm_key_vault_access_policy" "kms" {
  key_vault_id = azurerm_key_vault.des_vault.id
  object_id    = azurerm_user_assigned_identity.aks.principal_id
  tenant_id    = azurerm_user_assigned_identity.aks.tenant_id
  key_permissions = [
    "Decrypt",
    "Encrypt",
  ]
}

resource "azurerm_role_assignment" "kms" {
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  scope                = azurerm_key_vault.des_vault.id
  role_definition_name = "Key Vault Contributor"
}
