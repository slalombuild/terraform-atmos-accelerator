########
# RBAC #
########

data "azuread_group" "principal" {
  for_each = toset(flatten([for role, principal in var.role_assignment : principal]))

  display_name = each.value
}

resource "azurerm_role_assignment" "rbac" {
  for_each = { for idx, val in local.flattened_role_assignments : "${val.role}-${val.principal}" => val }

  principal_id         = each.value.principal
  scope                = data.azurerm_resource_group.apim_rg.id
  role_definition_name = each.value.role
}
