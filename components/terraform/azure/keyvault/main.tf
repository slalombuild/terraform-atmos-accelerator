resource "azurerm_resource_group" "keyvault" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(module.this.tags,
    {
      "Component" : "keyvault",
      "ExpenseClass" : "secrets"
    }
  )
}

module "azure_keyvault" {
  source                                 = "github.com/azure/terraform-azurerm-avm-res-keyvault-vault"
  name                                   = module.naming.key_vault.name
  location                               = var.location
  resource_group_name                    = data.azurerm_resource_group.keyvault.name
  tenant_id                              = data.azurerm_client_config.current.tenant_id
  contacts                               = var.contacts
  diagnostic_settings                    = local.diagnostic_settings
  enable_telemetry                       = var.enable_telemetry
  enabled_for_deployment                 = var.enabled_for_deployment
  enabled_for_disk_encryption            = var.enabled_for_disk_encryption
  enabled_for_template_deployment        = var.enabled_for_template_deployment
  keys                                   = var.keys
  lock                                   = var.lock
  network_acls                           = local.network_acls
  private_endpoints                      = var.private_endpoints
  public_network_access_enabled          = var.public_network_access_enabled
  purge_protection_enabled               = var.purge_protection_enabled
  role_assignments                       = local.role_assignments
  secrets                                = var.secrets
  secrets_value                          = var.secrets_value
  sku_name                               = var.sku_name
  soft_delete_retention_days             = var.soft_delete_retention_days
  wait_for_rbac_before_key_operations    = var.wait_for_rbac_before_key_operations
  wait_for_rbac_before_secret_operations = var.wait_for_rbac_before_secret_operations
}
