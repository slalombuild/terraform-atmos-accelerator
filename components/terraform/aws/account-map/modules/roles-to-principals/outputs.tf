output "aws_partition" {
  description = "The AWS \"partition\" to use when constructing resource ARNs"
  value       = local.aws_partition
}

output "full_account_map" {
  description = "Map of account names to account IDs"
  value       = module.account_map.outputs.full_account_map
}

output "permission_set_arn_like" {
  description = "List of Role ARN regexes suitable for IAM Condition `ArnLike` corresponding to given input `permission_set_map`"
  value       = local.permission_set_arn_like
}

output "principals" {
  description = "Consolidated list of AWS principals corresponding to given input `role_map`"
  value       = local.principals
}

output "principals_map" {
  description = "Map of AWS principals corresponding to given input `role_map`"
  value       = local.principals_map
}

output "team_permission_set_name_map" {
  description = "Map of team names (from `var.teams` and `role_map[\"identity\"]) to permission set names"
  value       = local.team_permission_set_name_map
}
