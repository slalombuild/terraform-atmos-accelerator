##########
# Subnet #
##########

data "azurerm_subnet" "subnet" {
  for_each = var.service_bus_namespace_name == null ? { for i in var.sb_network_rule_config.network_rules : i.subnet_name => i } : {}

  name                 = replace(module.vnet_naming[each.key].subnet.name, each.value.vnet_name, each.key)
  resource_group_name  = module.vnet_naming[each.key].resource_group.name
  virtual_network_name = module.vnet_naming[each.key].virtual_network.name
}

#######################
# Diagnostic settings #
#######################

data "azurerm_log_analytics_workspace" "la_diag" {
  for_each = var.service_bus_namespace_name == null && var.log_analytics_as_diagnostics_destination ? var.sb_diagnostic_settings : {}

  name                = module.diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.diagnostic_setting_naming[each.key].resource_group.name
}

data "azurerm_storage_account" "la_st" {
  for_each = var.service_bus_namespace_name == null && var.storage_account_as_diagnostics_destination ? var.sb_diagnostic_settings : {}

  name                = module.diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.diagnostic_setting_naming[each.key].resource_group.name
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "sb_rg" {
  count = var.service_bus_namespace_name == null ? 1 : 0

  name = var.resource_group_name == null ? azurerm_resource_group.sb_rg[0].name : var.resource_group_name
}

########################
# Current Subscription #
########################

data "azurerm_client_config" "current" {}

###############
# Service Bus #
###############

data "azurerm_servicebus_namespace" "sbus" {
  count = var.service_bus_namespace_name == null ? 0 : 1

  name                = "${module.sbus_naming[0].servicebus_namespace.name}us"
  resource_group_name = module.sbus_naming[0].resource_group.name
}
