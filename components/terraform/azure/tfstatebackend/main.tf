resource "azurerm_resource_group" "tfstate" {
  location = var.location
  name     = module.naming.resource_group.name
  tags     = module.this.tags
}

resource "azurerm_storage_account" "tfstate" {
  account_replication_type   = var.storage_account_replication_type
  account_tier               = var.storage_account_tier
  location                   = var.location
  name                       = module.naming.storage_account.name_unique
  resource_group_name        = azurerm_resource_group.tfstate.name
  access_tier                = "Hot"
  account_kind               = "StorageV2"
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"
  tags                       = module.this.tags

  identity {
    type = "SystemAssigned"
  }
  dynamic "network_rules" {
    for_each = length(keys(var.storage_account_network_rules)) > 0 ? [var.storage_account_network_rules] : []
    iterator = network_rules

    content {
      default_action             = lookup(network_rules.value, "default_action", null)
      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = lookup(network_rules.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", null)

      dynamic "private_link_access" {
        for_each = length(keys(lookup(network_rules.value, "private_link_access", {}))) > 0 ? [lookup(network_rules.value, "private_link_access", {})] : []
        iterator = private_link_access

        content {
          endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", null)
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = module.naming.storage_container.name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}


resource "azurerm_storage_account_network_rules" "tfstate" {
  count = var.enable_storage_account_network_rules ? 1 : 0

  default_action             = var.storage_account_network_rules_default_action
  storage_account_id         = azurerm_storage_account.tfstate.id
  bypass                     = var.storage_account_network_rules_bypass
  ip_rules                   = var.storage_account_network_rules_ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules_virtual_network_subnet_ids

  dynamic "private_link_access" {
    for_each = length(keys(var.storage_account_network_rules_private_link_access)) > 0 ? [var.storage_account_network_rules_private_link_access] : []
    iterator = private_link_access

    content {
      endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)
      endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", null)
    }
  }
  dynamic "timeouts" {
    for_each = length(keys(var.storage_account_network_rules_timeouts)) > 0 ? [var.storage_account_network_rules_timeouts] : []
    iterator = timeouts

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
    }
  }

  depends_on = [
    azurerm_storage_account.tfstate
  ]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
}
