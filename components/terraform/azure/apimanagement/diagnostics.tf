#######################
# Diagnostic Settings #
#######################
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  count = var.diagnostic_setting.enabled ? 1 : 0

  name                           = module.naming.monitor_diagnostic_setting.name
  target_resource_id             = azurerm_api_management.apim.id
  eventhub_authorization_rule_id = var.diagnostic_setting.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_setting.eventhub_name
  log_analytics_destination_type = var.diagnostic_setting.log_analytics_destination_type
  log_analytics_workspace_id     = try(data.azurerm_log_analytics_workspace.la_diag[0].id, null)
  storage_account_id             = try(data.azurerm_storage_account.la_st[0].id, null)

  enabled_log {
    category       = var.diagnostic_setting.logs.category
    category_group = var.diagnostic_setting.logs.category_group
  }
  metric {
    category = var.diagnostic_setting.metrics.category
    enabled  = var.diagnostic_setting.metrics.enabled
  }
}
