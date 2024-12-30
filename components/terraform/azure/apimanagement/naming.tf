module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "diagnostic_setting_naming" {
  count   = var.diagnostic_setting.enabled && (var.diagnostic_setting.log_analytics_workspace_name != null || var.diagnostic_setting.storage_account_name != null) ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = var.diagnostic_setting.log_analytics_workspace_name != null ? [module.this.namespace, module.this.environment, var.diagnostic_setting.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, var.diagnostic_setting.storage_account_name]
  suffix  = var.diagnostic_setting.storage_account_name != null ? [var.suffix] : []
}

module "vnet_naming" {
  for_each = { for i in var.virtual_network_configuration : i.subnet_name => i }
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.vnet_name]
}
