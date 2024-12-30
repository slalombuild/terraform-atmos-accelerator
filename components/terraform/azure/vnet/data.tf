#######################
# Diagnostic settings #
#######################

data "azurerm_log_analytics_workspace" "la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings : {}

  name                = module.diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.diagnostic_setting_naming[each.key].resource_group.name
}

data "azurerm_storage_account" "la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings : {}

  name                = module.diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.diagnostic_setting_naming[each.key].resource_group.name
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "vnet" {
  name = var.resource_group_name == null ? azurerm_resource_group.vnet[0].name : var.resource_group_name
}
