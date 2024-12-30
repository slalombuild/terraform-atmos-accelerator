##########
# Subnet #
##########

data "azurerm_subnet" "subnet" {
  for_each = { for i in var.network_rules.virtual_network_subnets : i.subnet_name => i }

  name                 = replace(module.vnet_naming[each.key].subnet.name, each.value.vnet_name, each.key)
  resource_group_name  = module.vnet_naming[each.key].resource_group.name
  virtual_network_name = module.vnet_naming[each.key].virtual_network.name
}


###############################
# Diagnostic settings storage #
###############################

data "azurerm_log_analytics_workspace" "storage_la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings_storage_account : {}

  name                = module.storage_diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.storage_diagnostic_setting_naming[each.key].resource_group.name
}
data "azurerm_storage_account" "storage_la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_storage_account : {}

  name                = module.storage_diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.storage_diagnostic_setting_naming[each.key].resource_group.name
}

############################
# Diagnostic settings blob #
############################

data "azurerm_log_analytics_workspace" "blob_la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings_blob : {}

  name                = module.blob_diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.blob_diagnostic_setting_naming[each.key].resource_group.name
}
data "azurerm_storage_account" "blob_la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_blob : {}

  name                = module.blob_diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.blob_diagnostic_setting_naming[each.key].resource_group.name
}

#############################
# Diagnostic settings queue #
#############################

data "azurerm_log_analytics_workspace" "queue_la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings_queue : {}

  name                = module.queue_diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.queue_diagnostic_setting_naming[each.key].resource_group.name
}
data "azurerm_storage_account" "queue_la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_queue : {}

  name                = module.queue_diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.queue_diagnostic_setting_naming[each.key].resource_group.name
}

#############################
# Diagnostic settings table #
#############################

data "azurerm_log_analytics_workspace" "table_la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings_table : {}

  name                = module.table_diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.table_diagnostic_setting_naming[each.key].resource_group.name
}
data "azurerm_storage_account" "table_la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_table : {}

  name                = module.table_diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.table_diagnostic_setting_naming[each.key].resource_group.name
}

############################
# Diagnostic settings file #
############################

data "azurerm_log_analytics_workspace" "file_la_diag" {
  for_each = var.log_analytics_as_diagnostics_destination ? var.diagnostic_settings_file : {}

  name                = module.file_diagnostic_setting_naming[each.key].log_analytics_workspace.name
  resource_group_name = module.file_diagnostic_setting_naming[each.key].resource_group.name
}
data "azurerm_storage_account" "file_la_st" {
  for_each = var.storage_account_as_diagnostics_destination ? var.diagnostic_settings_file : {}

  name                = module.file_diagnostic_setting_naming[each.key].storage_account.name
  resource_group_name = module.file_diagnostic_setting_naming[each.key].resource_group.name
}
