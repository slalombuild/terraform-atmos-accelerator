##################
# Resource Group #
##################

resource "azurerm_resource_group" "sb_rg" {
  count = var.service_bus_namespace_name == null && var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      "Component"    = "servicebus"
      "ExpenseClass" = "messages"
    }
  )
}

##############
# ServiceBus #
##############

module "service_bus" {
  count                                   = var.service_bus_namespace_name == null ? 1 : 0
  source                                  = "github.com/Azure/terraform-azurerm-avm-res-servicebus-namespace"
  location                                = var.location
  name                                    = "${module.naming.servicebus_namespace.name}us"
  resource_group_name                     = data.azurerm_resource_group.sb_rg[0].name
  sku                                     = var.service_bus.sku
  capacity                                = var.service_bus.capacity
  zone_redundant                          = var.service_bus.zone_redundant
  authorization_rules                     = var.sb_authorization_rules
  customer_managed_key                    = var.sb_customer_managed_key
  diagnostic_settings                     = local.sb_diagnostic_settings
  enable_telemetry                        = var.service_bus.enable_telemetry
  infrastructure_encryption_enabled       = var.service_bus.infrastructure_encryption_enabled
  local_auth_enabled                      = var.service_bus.local_auth_enabled
  lock                                    = var.service_bus.resource_lock
  managed_identities                      = var.service_bus.managed_identities
  minimum_tls_version                     = var.service_bus.minimum_tls_version
  premium_messaging_partitions            = var.service_bus.premium_messaging_partitions
  public_network_access_enabled           = var.service_bus.public_network_access_enabled
  private_endpoints_manage_dns_zone_group = var.sb_private_endpoints_manage_dns_zone_group
  private_endpoints                       = var.sb_private_endpoints
  network_rule_config                     = local.sb_network_rule_config

  role_assignments = local.sb_role_assignments

  topics = var.topics
  queues = var.queues

  tags = merge(
    module.this.tags,
    {
      "ResourceGroup" = data.azurerm_resource_group.sb_rg[0].name
    }
  )
}

resource "azurerm_servicebus_queue" "queue" {
  for_each = var.service_bus_namespace_name == null ? {} : var.queues

  name                                    = each.value.name != null ? each.value.name : each.key
  namespace_id                            = local.service_bus_id
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  default_message_ttl                     = each.value.default_message_ttl
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  enable_batched_operations               = each.value.enable_batched_operations
  enable_express                          = each.value.enable_express
  enable_partitioning                     = each.value.enable_partitioning
  forward_dead_lettered_messages_to       = each.value.forward_dead_lettered_messages_to
  forward_to                              = each.value.forward_to
  lock_duration                           = each.value.lock_duration
  max_delivery_count                      = each.value.max_delivery_count
  max_message_size_in_kilobytes           = each.value.max_message_size_in_kilobytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  requires_session                        = each.value.requires_session
  status                                  = each.value.status
}
