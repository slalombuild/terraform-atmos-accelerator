locals {
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
}
