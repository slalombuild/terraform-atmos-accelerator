module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "windows_naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name, "win"]
}

module "cosmosdb_account_naming" {
  count   = var.function_app_settings.cosmosdb_account_name != null ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.function_app_settings.cosmosdb_account_name]
}

module "appinsights_naming" {
  count   = var.function_app_settings.appinsights_name != null ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.function_app_settings.appinsights_name]
}

module "diagnostic_setting_naming" {
  count   = var.diagnostic_setting.enabled && (var.diagnostic_setting.log_analytics_workspace_name != null || var.diagnostic_setting.storage_account_name != null) ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = var.diagnostic_setting.log_analytics_workspace_name != null ? [module.this.namespace, module.this.environment, var.diagnostic_setting.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, var.diagnostic_setting.storage_account_name]
  suffix  = var.diagnostic_setting.storage_account_name != null ? [var.suffix] : []
}

module "vnet_naming" {
  count   = var.function_app_vnet_integration != null ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.function_app_vnet_integration.vnet_name]
}

module "subnet_naming" {
  for_each = { for subnet in var.authorized_subnets : subnet.subnet_name => subnet }
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.vnet_name]
}

module "apim_naming" {
  for_each = length(var.api_management_backends) > 0 ? { for backend, _ in var.api_management_backends : backend => _ } : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.apim_name]
}
