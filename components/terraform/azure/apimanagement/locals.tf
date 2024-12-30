locals {
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
  virtual_network_configuration = length(var.virtual_network_configuration) > 0 ? [for i in var.virtual_network_configuration : data.azurerm_subnet.subnet[i.subnet_name].id] : []
}
