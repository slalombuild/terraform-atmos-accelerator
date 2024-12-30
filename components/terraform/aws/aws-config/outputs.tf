output "aws_config_configuration_recorder_id" {
  description = "The ID of the AWS Config Recorder"
  value       = module.aws_config.aws_config_configuration_recorder_id
}

output "aws_config_iam_role" {
  description = "The ARN of the IAM Role used for AWS Config"
  value       = local.config_iam_role_arn
}

output "storage_bucket_arn" {
  description = "Storage Config bucket ARN"
  value       = module.aws_config.storage_bucket_arn
}

output "storage_bucket_id" {
  description = "Storage Config bucket ID"
  value       = module.aws_config.storage_bucket_id
}
