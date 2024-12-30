data "azuread_group" "principal" {
  for_each = toset(flatten([for role, principal in var.role_assignment : principal]))

  display_name = each.value
}

data "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name != null ? var.app_service_plan_name : azurerm_service_plan.plan[0].name
  resource_group_name = data.azurerm_resource_group.func_rg.name
}

data "azurerm_subnet" "vnet_subnet" {
  count = var.function_app_vnet_integration != null ? 1 : 0

  name                 = replace(module.vnet_naming[0].subnet.name, var.function_app_vnet_integration.vnet_name, var.function_app_vnet_integration.subnet_name)
  resource_group_name  = module.vnet_naming[0].resource_group.name
  virtual_network_name = module.vnet_naming[0].virtual_network.name
}

data "azurerm_subnet" "authorized_subnets" {
  for_each = { for subnet in var.authorized_subnets : subnet.subnet_name => subnet }

  name                 = replace(module.subnet_naming[each.key].subnet.name, each.value.vnet_name, each.key)
  resource_group_name  = module.subnet_naming[each.key].resource_group.name
  virtual_network_name = module.subnet_naming[each.key].virtual_network.name
}

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

data "azurerm_cosmosdb_account" "cosmos" {
  count = var.function_app_settings.cosmosdb_account_name != null ? 1 : 0

  name                = module.cosmosdb_account_naming[0].cosmosdb_account.name
  resource_group_name = module.cosmosdb_account_naming[0].resource_group.name
}

data "azurerm_application_insights" "appinsights" {
  count = var.function_app_settings.appinsights_name != null ? 1 : 0

  name                = module.appinsights_naming[0].application_insights.name
  resource_group_name = module.appinsights_naming[0].resource_group.name
}

data "azurerm_subscription" "current" {}

##################
# Resource Group #
##################

data "azurerm_resource_group" "func_rg" {
  name = var.resource_group_name == null ? azurerm_resource_group.rg[0].name : var.resource_group_name
}
