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

##########
# Subnet #
##########

data "azurerm_subnet" "subnet" {
  for_each = { for i in var.virtual_network_configuration : i.subnet_name => i }

  name                 = replace(module.vnet_naming[each.key].subnet.name, each.value.vnet_name, each.key)
  resource_group_name  = module.vnet_naming[each.key].resource_group.name
  virtual_network_name = module.vnet_naming[each.key].virtual_network.name
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "apim_rg" {
  name = var.resource_group_name == null ? azurerm_resource_group.apim_rg[0].name : var.resource_group_name
}
