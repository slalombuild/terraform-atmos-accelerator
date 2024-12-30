locals {
  diagnostic_settings = length(var.diagnostic_settings) > 0 ? { for i, j in var.diagnostic_settings : i => {
    name                                     = j.name != null ? j.name : module.naming.monitor_diagnostic_setting.name
    log_categories_and_groups                = j.log_categories_and_groups
    metric_categories                        = j.metric_categories
    log_analytics_destination_type           = j.log_analytics_destination_type
    workspace_resource_id                    = try(data.azurerm_log_analytics_workspace.la_diag[i].id, null)
    storage_account_resource_id              = try(data.azurerm_storage_account.la_st[i].id, null)
    event_hub_authorization_rule_resource_id = j.event_hub_authorization_rule_resource_id
    event_hub_name                           = j.event_hub_name
    marketplace_partner_resource_id          = j.marketplace_partner_resource_id
  } } : {}
  subnets = length(var.subnets) > 0 ? { for k, v in var.subnets : k => {
    name             = replace(module.naming.subnet.name, module.this.name, k)
    address_prefixes = v.address_prefixes
    nat_gateway      = v.nat_gateway
    network_security_group = var.create_network_security_group && v.network_security_group_name != null ? {
      id = azurerm_network_security_group.nsg[v.network_security_group_name].id
    } : null
    private_endpoint_network_policies_enabled     = v.private_endpoint_network_policies_enabled
    private_link_service_network_policies_enabled = v.private_link_service_network_policies_enabled
    route_table                                   = v.route_table
    service_endpoints                             = v.service_endpoints
    service_endpoint_policy_ids                   = v.service_endpoint_policy_ids
    delegation                                    = v.delegation
    }
  } : {}
}
