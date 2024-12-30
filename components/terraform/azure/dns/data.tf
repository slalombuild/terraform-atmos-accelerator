data "azuread_group" "principal" {
  for_each = toset(flatten([for role, principal in var.role_assignment : principal]))

  display_name = each.value
}

##################
# Resource Group #
##################

data "azurerm_resource_group" "dns_rg" {
  name = var.resource_group_name == null ? azurerm_resource_group.rg[0].name : var.resource_group_name
}
