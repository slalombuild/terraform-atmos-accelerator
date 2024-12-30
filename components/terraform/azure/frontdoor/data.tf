#######################
# Diagnostic Settings #
#######################
data "azurerm_log_analytics_workspace" "la_diag" {
  count = var.diagnostic_setting.enabled && var.diagnostic_setting.log_analytics_workspace_name != null ? 1 : 0

  name                = module.diagnostic_setting_naming[0].log_analytics_workspace.name
  resource_group_name = module.diagnostic_setting_naming[0].resource_group.name
}

data "azurerm_storage_account" "la_st" {
  count = var.diagnostic_setting.enabled && var.diagnostic_setting.storage_account_name != null ? 1 : 0

  name                = module.diagnostic_setting_naming[0].storage_account.name
  resource_group_name = module.diagnostic_setting_naming[0].resource_group.name
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "fd_rg" {
  name = var.resource_group_name == null ? azurerm_resource_group.fd_rg[0].name : var.resource_group_name
}
