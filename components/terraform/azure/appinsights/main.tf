##################
# Resource Group #
##################

resource "azurerm_resource_group" "ai_rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      "Component"    = "appinsights"
      "ExpenseClass" = "monitoring"
    }
  )
}

################
# App Insights #
################


data "azurerm_log_analytics_workspace" "this" {
  count = var.log_analytics_workspace.name != null ? 1 : 0

  name                = module.la_workspace_naming[0].log_analytics_workspace.name
  resource_group_name = module.la_workspace_naming[0].resource_group.name
}

resource "azurerm_log_analytics_workspace" "this" {
  count = var.log_analytics_workspace.name == null ? 1 : 0

  location                                = var.location
  name                                    = "${module.naming.application_insights.name}-la-workspace"
  resource_group_name                     = data.azurerm_resource_group.ai_rg.name
  allow_resource_only_permissions         = var.log_analytics_workspace.allow_resource_only_permissions
  cmk_for_query_forced                    = var.log_analytics_workspace.cmk_for_query_forced
  daily_quota_gb                          = var.log_analytics_workspace.daily_quota_gb
  data_collection_rule_id                 = var.log_analytics_workspace.data_collection_rule_id
  immediate_data_purge_on_30_days_enabled = var.log_analytics_workspace.immediate_data_purge_on_30_days_enabled
  internet_ingestion_enabled              = var.log_analytics_workspace.internet_ingestion_enabled
  internet_query_enabled                  = var.log_analytics_workspace.internet_query_enabled
  local_authentication_disabled           = var.log_analytics_workspace.local_authentication_disabled
  reservation_capacity_in_gb_per_day      = var.log_analytics_workspace.reservation_capacity_in_gb_per_day
  retention_in_days                       = var.log_analytics_workspace.retention_in_days
  sku                                     = var.log_analytics_workspace.sku
  tags = merge(
    module.this.tags,
    {
      "ResourceGroup" = data.azurerm_resource_group.ai_rg.name
    }
  )

  dynamic "identity" {
    for_each = var.log_analytics_workspace.identity_type != null ? ["enabled"] : []

    content {
      type         = var.log_analytics_workspace.identity_type
      identity_ids = var.log_analytics_workspace.identity_type == "UserAssigned" ? var.log_analytics_workspace.identity_ids : []
    }
  }
}

resource "azurerm_application_insights" "app_insights" {
  application_type                      = var.application_type
  location                              = var.location
  name                                  = module.naming.application_insights.name
  resource_group_name                   = data.azurerm_resource_group.ai_rg.name
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  disable_ip_masking                    = var.disable_ip_masking
  force_customer_storage_for_profiler   = var.force_customer_storage_for_profiler
  internet_ingestion_enabled            = var.internet_ingestion_enabled
  internet_query_enabled                = var.internet_query_enabled
  local_authentication_disabled         = var.local_authentication_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  tags = merge(
    module.this.tags,
    {
      "ResourceGroup" = data.azurerm_resource_group.ai_rg.name
    }
  )
  workspace_id = var.log_analytics_workspace.name == null ? azurerm_log_analytics_workspace.this[0].id : try(data.azurerm_log_analytics_workspace.this[0].id, null)
}

#########################
# Smart Detector Alerts #
#########################
resource "azurerm_monitor_smart_detector_alert_rule" "this" {
  for_each = var.smart_detector_alert_rules.enabled ? local.smart_detector_alert_rules : {}

  detector_type       = each.value["detector_type"]
  frequency           = each.value["frequency"]
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.ai_rg.name
  scope_resource_ids  = [azurerm_application_insights.app_insights.id]
  severity            = each.value["severity"]
  description         = each.value["description"]
  enabled             = var.smart_detector_alert_rules.rule_enabled
  tags = merge(
    module.this.tags,
    {
      "ResourceGroup" = data.azurerm_resource_group.ai_rg.name
    }
  )

  action_group {
    ids = var.smart_detector_alert_rules.action_group_ids
  }
}

#######################
# Diagnostic Settings #
#######################

resource "azurerm_monitor_diagnostic_setting" "main" {
  count = var.diagnostic_setting.enabled ? 1 : 0

  name                           = module.naming.monitor_diagnostic_setting.name
  target_resource_id             = azurerm_application_insights.app_insights.id
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
