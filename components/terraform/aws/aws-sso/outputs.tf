output "permission_sets" {
  description = "Permission sets"
  value       = module.permission_sets.permission_sets
}

output "sso_account_assignments" {
  description = "SSO account assignments"
  value       = module.sso_account_assignments.assignments
}
