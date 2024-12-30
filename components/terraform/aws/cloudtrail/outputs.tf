output "cloudtrail_arn" {
  description = "CloudTrail ARN"
  value       = module.cloudtrail.cloudtrail_arn
}

output "cloudtrail_home_region" {
  description = "The region in which CloudTrail was created"
  value       = module.cloudtrail.cloudtrail_home_region
}

output "cloudtrail_id" {
  description = "CloudTrail ID"
  value       = module.cloudtrail.cloudtrail_id
}

output "cloudtrail_logs_log_group_arn" {
  description = "CloudTrail Logs log group ARN"
  value       = local.enabled ? join("", aws_cloudwatch_log_group.cloudtrail_cloudwatch_logs[*].arn) : null
}

output "cloudtrail_logs_log_group_name" {
  description = "CloudTrail Logs log group name"
  value       = local.enabled ? join("", aws_cloudwatch_log_group.cloudtrail_cloudwatch_logs[*].name) : null
}

output "cloudtrail_logs_role_arn" {
  description = "CloudTrail Logs role ARN"
  value       = local.enabled ? join("", aws_iam_role.cloudtrail_cloudwatch_logs[*].arn) : null
}

output "cloudtrail_logs_role_name" {
  description = "CloudTrail Logs role name"
  value       = local.enabled ? join("", aws_iam_role.cloudtrail_cloudwatch_logs[*].name) : null
}
