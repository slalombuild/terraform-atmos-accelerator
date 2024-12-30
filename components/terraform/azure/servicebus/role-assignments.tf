########
# RBAC #
########
data "azuread_group" "principal" {
  for_each = var.service_bus_namespace_name == null ? { for i, j in var.sb_role_assignments : j.principal_name => j } : {}

  display_name = each.value.principal_name
}
