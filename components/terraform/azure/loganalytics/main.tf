##################
# Resource Group #
##################

resource "azurerm_resource_group" "la_rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      "Component"    = "loganalytics"
      "ExpenseClass" = "monitoring"
    }
  )
}

###########################
# Log Analytics Workspace #
###########################

resource "azurerm_log_analytics_workspace" "this" {
  location                                = var.location
  name                                    = module.naming.log_analytics_workspace.name
  resource_group_name                     = data.azurerm_resource_group.la_rg.name
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
      "ResourceGroup" = data.azurerm_resource_group.la_rg.name
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
