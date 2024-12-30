locals {
  sb_diagnostic_settings = var.service_bus_namespace_name == null && length(var.sb_diagnostic_settings) > 0 ? { for i, j in var.sb_diagnostic_settings : i => {
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
  sb_network_rule_config = {
    trusted_services_allowed = var.sb_network_rule_config.trusted_services_allowed
    cidr_or_ip_rules         = var.sb_network_rule_config.cidr_or_ip_rules
    default_action           = var.sb_network_rule_config.default_action
    network_rules = var.service_bus_namespace_name == null && length(var.sb_network_rule_config.network_rules) > 0 ? [for i in var.sb_network_rule_config.network_rules : {
      subnet_id = data.azurerm_subnet.subnet[i.subnet_name].id
    }] : []
  }
  sb_role_assignments = var.service_bus_namespace_name == null && length(var.sb_role_assignments) > 0 ? { for i, j in var.sb_role_assignments : i => {
    role_definition_id_or_name = j.role_definition_id_or_name
    principal_id               = data.azuread_group.principal[j.principal_name].object_id

    description                            = j.description
    skip_service_principal_aad_check       = j.skip_service_principal_aad_check
    delegated_managed_identity_resource_id = j.delegated_managed_identity_resource_id
  } } : {}
  service_bus_id = var.service_bus_namespace_name == null ? null : format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.ServiceBus/namespaces/%s", "${data.azurerm_client_config.current.subscription_id}", "${data.azurerm_servicebus_namespace.sbus[0].resource_group_name}", "${data.azurerm_servicebus_namespace.sbus[0].name}")
}
