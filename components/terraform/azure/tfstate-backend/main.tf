resource "azurerm_resource_group" "tfstate" {
  count = var.create_resource_group ? 1 : 0

  location = local.resource_group.location
  name     = local.resource_group.name
  tags     = module.this.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name == null ? module.naming.storage_account.name : var.storage_account_name
  resource_group_name      = local.resource_group.name
  location                 = local.resource_group.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  access_tier  = "Hot"
  account_kind = "StorageV2"

  identity {
    type = "SystemAssigned"
  }

  dynamic "network_rules" {
    iterator = network_rules
    for_each = length(keys(var.storage_account_network_rules)) > 0 ? [var.storage_account_network_rules] : []

    content {
      default_action = lookup(network_rules.value, "default_action", null)

      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = lookup(network_rules.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", null)

      dynamic "private_link_access" {
        iterator = private_link_access
        for_each = length(keys(lookup(network_rules.value, "private_link_access", {}))) > 0 ? [lookup(network_rules.value, "private_link_access", {})] : []
        content {
          endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", null)
        }
      }
    }
  }

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  tags = module.this.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = module.naming.storage_container.name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"

}

resource "azurerm_key_vault" "tfstate" {
  name                = var.key_vault_name == null ? module.naming.key_vault.name : var.key_vault_name
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = var.key_vault_firewall_bypass_ip_cidr
  }
  purge_protection_enabled = true
  tags                     = module.this.tags
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = azurerm_key_vault.tfstate.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.tfstate.identity[0].principal_id

  key_permissions    = ["Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.tfstate.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "tfstate" {
  name         = module.naming.key_vault_key.name
  key_vault_id = azurerm_key_vault.tfstate.id
  key_type     = var.key_vault_key_type # RSA or RSA-HSM
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage,
  ]
  expiration_date = var.key_vault_key_expiration_date
  tags            = module.this.tags
}

resource "azurerm_storage_account_customer_managed_key" "tfstate" {
  storage_account_id = azurerm_storage_account.tfstate.id
  key_vault_id       = azurerm_key_vault.tfstate.id
  key_name           = azurerm_key_vault_key.tfstate.name
  key_version        = null # null enables automatic key rotation
}

resource "azurerm_storage_account_network_rules" "tfstate" {
  count                      = var.enable_storage_account_network_rules ? 1 : 0
  default_action             = var.storage_account_network_rules_default_action
  storage_account_id         = azurerm_storage_account.tfstate.id
  bypass                     = var.storage_account_network_rules_bypass
  ip_rules                   = var.storage_account_network_rules_ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules_virtual_network_subnet_ids

  dynamic "private_link_access" {
    iterator = private_link_access
    for_each = length(keys(var.storage_account_network_rules_private_link_access)) > 0 ? [var.storage_account_network_rules_private_link_access] : []

    content {
      endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)

      endpoint_tenant_id = lookup(private_link_access.value, "endpoint_tenant_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_account_network_rules_timeouts)) > 0 ? [var.storage_account_network_rules_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_storage_account.tfstate
  ]
}
