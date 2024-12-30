resource "local_file" "account_info" {
  content = templatefile("${path.module}/../aws-team-roles/iam-role-info.tftmpl", {
    role_name_map          = local.role_name_map
    role_name_role_arn_map = local.role_name_role_arn_map
    namespace              = module.this.namespace
  })
  filename = "${path.module}/../aws-team-roles/iam-role-info/${module.this.id}-teams.sh"
}

output "role_arns" {
  description = "List of role ARNs"
  value       = values(aws_iam_role.default)[*].arn
}

output "team_name_role_arn_map" {
  description = "Map of team names to role ARNs"
  value       = local.role_name_role_arn_map
}

output "team_names" {
  description = "List of team names"
  value       = values(aws_iam_role.default)[*].name
}

output "teams_config" {
  description = "Map of team config with name, target arn, and description"
  value       = var.teams_config
}
