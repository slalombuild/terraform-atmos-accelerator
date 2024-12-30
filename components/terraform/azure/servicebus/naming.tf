module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "diagnostic_setting_naming" {
  for_each = var.service_bus_namespace_name == null && (var.log_analytics_as_diagnostics_destination || var.storage_account_as_diagnostics_destination) ? var.sb_diagnostic_settings : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = var.log_analytics_as_diagnostics_destination ? [module.this.namespace, module.this.environment, each.value.log_analytics_workspace_name] : [module.this.namespace, module.this.environment, each.value.storage_account_name]
  suffix   = var.storage_account_as_diagnostics_destination ? [var.suffix] : []
}

module "vnet_naming" {
  for_each = var.service_bus_namespace_name == null ? { for i in var.sb_network_rule_config.network_rules : i.subnet_name => i } : {}
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.vnet_name]
}

module "sbus_naming" {
  count   = var.service_bus_namespace_name == null ? 0 : 1
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.service_bus_namespace_name]
}
