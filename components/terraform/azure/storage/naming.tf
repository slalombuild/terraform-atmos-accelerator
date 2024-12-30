module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "storage_naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
  suffix  = [var.suffix]
}

module "vnet_naming" {
  for_each = { for i in var.network_rules.virtual_network_subnets : i.subnet_name => i }
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.vnet_name]
}

module "storage_diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_storage_account : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}

module "blob_diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_blob : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}

module "queue_diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_queue : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}

module "table_diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_table : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}

module "file_diagnostic_setting_naming" {
  for_each = var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_file : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}
