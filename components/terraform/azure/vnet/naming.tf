module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}
