locals {
  diagnostic_settings = length(var.diagnostic_settings) > 0 ? { for i, j in var.diagnostic_settings : i => {
    name                                     = j.name != null ? j.name : module.naming.monitor_diagnostic_setting.name
    log_categories                           = j.log_categories
    log_groups                               = j.log_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  network_acls = {
    bypass                     = var.network_acls.bypass
    default_action             = var.network_acls.default_action
    ip_rules                   = var.network_acls.ip_rules
    virtual_network_subnet_ids = length(var.network_acls.virtual_network_subnet_ids) > 0 ? var.network_acls.virtual_network_subnet_ids : (length(var.network_acls.virtual_network_subnets) > 0 ? [for i in var.network_acls.virtual_network_subnets : data.azurerm_subnet.subnet[i.subnet_name].id] : [])
  }
  role_assignments = length(var.role_assignments) > 0 ? { for i, j in var.role_assignments : i => {
    role_definition_id_or_name = j.role_definition_id_or_name
    principal_id               = data.azuread_group.principal[j.principal_name].object_id

    description                            = j.description
    skip_service_principal_aad_check       = j.skip_service_principal_aad_check
    delegated_managed_identity_resource_id = j.delegated_managed_identity_resource_id
  } } : {}
}
