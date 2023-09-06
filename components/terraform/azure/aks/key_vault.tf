data "azurerm_client_config" "current" {}

data "http" "public_ip" {
  count = var.key_vault_firewall_bypass_ip_cidr == null ? 1 : 0

  url = "http://ipv4.icanhazip.com"
}

locals {
  public_ip = var.key_vault_firewall_bypass_ip_cidr == null ? replace(data.http.public_ip[0].response_body, "\n", "") : var.key_vault_firewall_bypass_ip_cidr
}

resource "random_string" "key_vault_prefix" {
  length  = 6
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_key_vault" "des_vault" {
  location                    = local.resource_group.location
  name                        = module.naming.key_vault.name_unique
  resource_group_name         = local.resource_group.name
  sku_name                    = "premium"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = [local.public_ip]
  }

  depends_on = [
    azurerm_resource_group.main
  ]

  tags = var.default_tags
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.des_vault.id
  object_id    = coalesce(var.managed_identity_principal_id, data.azurerm_client_config.current.object_id)
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_permissions = [
    "Get",
    "Create",
    "Delete",
    "GetRotationPolicy",
    "Recover",
  ]
}
