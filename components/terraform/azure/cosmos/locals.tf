locals {
  create_cosmosdb_account = var.cosmosdb_account_name == null
  default_failover_locations = {
    default = {
      location          = var.location
      failover_priority = 0
      zone_redundant    = true
    }
  }
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
  # resource_group_name = local.create_cosmosdb_account ? coalesce(var.resource_group_name, module.naming.resource_group.name) : module.cosmosdb_naming[0].resource_group.name
  virtual_network_rule = length(var.virtual_network_rule) > 0 ? [for i in var.virtual_network_rule : {
    id                                   = data.azurerm_subnet.subnet[i.subnet_name].id
    ignore_missing_vnet_service_endpoint = i.ignore_missing_vnet_service_endpoint
  }] : []
}
