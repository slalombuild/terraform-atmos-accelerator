locals {
  blob_endpoint = length(var.containers) == 0 ? [] : ["blob"]
  # Role assignments for containers
  containers_role_assignments = { for ra in flatten([
    for ck, cv in var.containers : [
      for rk, rv in cv.role_assignments : {
        container_key   = ck
        ra_key          = rk
        role_assignment = rv
      }
    ]
  ]) : "${ra.container_key}-${ra.ra_key}" => ra }
  # Diagnostic settings for blob
  diagnostic_settings_blob = length(var.diagnostic_settings_blob) > 0 ? { for i, j in var.diagnostic_settings_blob : i => {
    name                                     = j.name != null ? j.name : "${module.naming.monitor_diagnostic_setting.name}-blob"
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.blob_la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.blob_la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  # Diagnostic settings for file
  diagnostic_settings_file = length(var.diagnostic_settings_file) > 0 ? { for i, j in var.diagnostic_settings_file : i => {
    name                                     = j.name != null ? j.name : "${module.naming.monitor_diagnostic_setting.name}-file"
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.file_la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.file_la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  # Diagnostic settings for queue
  diagnostic_settings_queue = length(var.diagnostic_settings_queue) > 0 ? { for i, j in var.diagnostic_settings_queue : i => {
    name                                     = j.name != null ? j.name : "${module.naming.monitor_diagnostic_setting.name}-queue"
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.queue_la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.queue_la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  # Diagnostic settings for storage account
  diagnostic_settings_storage_account = length(var.diagnostic_settings_storage_account) > 0 ? { for i, j in var.diagnostic_settings_storage_account : i => {
    name                                     = j.name != null ? j.name : "${module.naming.monitor_diagnostic_setting.name}-storage"
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.storage_la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.storage_la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  # Diagnostic settings for table
  diagnostic_settings_table = length(var.diagnostic_settings_table) > 0 ? { for i, j in var.diagnostic_settings_table : i => {
    name                                     = j.name != null ? j.name : "${module.naming.monitor_diagnostic_setting.name}-table"
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.table_la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.table_la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  endpoints = toset(concat(local.blob_endpoint, local.queue_endpoint, local.table_endpoint))
  location  = var.location
  network_rules = {
    bypass                     = var.network_rules.bypass
    default_action             = var.network_rules.default_action
    ip_rules                   = var.network_rules.ip_rules
    virtual_network_subnet_ids = length(var.network_rules.virtual_network_subnets) > 0 ? [for i in var.network_rules.virtual_network_subnets : data.azurerm_subnet.subnet[i.subnet_name].id] : []
    private_link_access        = var.network_rules.private_link_access
    timeouts                   = var.network_rules.timeouts
  }
  # private endpoint role assignments
  pe_role_assignments = { for ra in flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for rk, rv in pe_v.role_assignments : {
        private_endpoint_key = pe_k
        ra_key               = rk
        role_assignment      = rv
      }
    ]
  ]) : "${ra.private_endpoint_key}-${ra.ra_key}" => ra }
  # Private endpoint application security group associations
  private_endpoint_application_security_group_associations = { for assoc in flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for asg_k, asg_v in pe_v.application_security_group_associations : {
        asg_key         = asg_k
        pe_key          = pe_k
        asg_resource_id = asg_v
      }
    ]
  ]) : "${assoc.pe_key}-${assoc.asg_key}" => assoc }
  private_endpoint_enabled = var.private_endpoints != null
  private_endpoints        = local.private_endpoint_enabled ? local.endpoints : toset([])
  queue_endpoint           = length(var.queues) == 0 ? [] : ["queue"]
  # Role assignments for queues
  queues_role_assignments = { for ra in flatten([
    for qk, qv in var.queues : [
      for rk, rv in qv.role_assignments : {
        queue_key       = qk
        ra_key          = rk
        role_assignment = rv
      }
    ]
  ]) : "${ra.queue_key}-${ra.ra_key}" => ra }
  resource_group_name                = var.resource_group_name == null ? azurerm_resource_group.storage[0].name : var.resource_group_name
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
  # Role assignments for shares
  shares_role_assignments = { for ra in flatten([
    for sk, sv in var.shares : [
      for rk, rv in sv.role_assignments : {
        share_key       = sk
        ra_key          = rk
        role_assignment = rv
      }
    ]
  ]) : "${ra.share_key}-${ra.ra_key}" => ra }
  table_endpoint = length(var.tables) == 0 ? [] : ["table"]
  # Role assignments for tables
  tables_role_assignments = { for ra in flatten([
    for tk, tv in var.tables : [
      for rk, rv in tv.role_assignments : {
        table_key       = tk
        ra_key          = rk
        role_assignment = rv
      }
    ]
  ]) : "${ra.table_key}-${ra.ra_key}" => ra }
}
