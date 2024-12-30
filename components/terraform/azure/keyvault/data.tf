data "azurerm_client_config" "current" {}

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


##########
# Subnet #
##########

data "azurerm_subnet" "subnet" {
  for_each = { for i in var.network_acls.virtual_network_subnets : i.subnet_name => i }

  name                 = replace(module.vnet_naming[each.key].subnet.name, each.value.vnet_name, each.key)
  resource_group_name  = module.vnet_naming[each.key].resource_group.name
  virtual_network_name = module.vnet_naming[each.key].virtual_network.name
}

########
# RBAC #
########
data "azuread_group" "principal" {
  for_each = { for i, j in var.role_assignments : j.principal_name => j }

  display_name = each.value.principal_name
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "keyvault" {
  name = var.resource_group_name == null ? azurerm_resource_group.keyvault[0].name : var.resource_group_name
}
