module "naming" {
  source        = "Azure/naming/azurerm"
  version       = "0.4.0"
  unique-length = 4
  suffix        = [var.suffix]
}

resource "azurerm_key_vault" "this" {
  name      = module.naming.key_vault.name_unique
  tenant_id = data.azurerm_client_config.current.tenant_id


  location            = var.location
  resource_group_name = var.resource_group_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enable_rbac_authorization = var.rbac_authorization_enabled

  public_network_access_enabled = var.public_network_access_enabled

  sku_name = var.sku_name

  tags = var.extra_tags

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]
    iterator = acl
    content {
      bypass                     = acl.value.bypass
      default_action             = acl.value.default_action
      ip_rules                   = acl.value.ip_rules
      virtual_network_subnet_ids = acl.value.virtual_network_subnet_ids
    }
  }
}

resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.rbac_authorization_enabled ? [] : var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.rbac_authorization_enabled ? [] : var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]
}

resource "azurerm_role_assignment" "rbac_keyvault_administrator" {
  for_each = toset(var.rbac_authorization_enabled ? var.admin_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "rbac_keyvault_secrets_users" {
  for_each = toset(var.rbac_authorization_enabled ? var.reader_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "rbac_keyvault_reader" {
  for_each = toset(var.rbac_authorization_enabled ? var.reader_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Reader"
  principal_id         = each.value
}
