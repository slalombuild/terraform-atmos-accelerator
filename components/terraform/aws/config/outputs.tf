# Outputs for config
output "config_recorder_id" {
  description = "The id of the AWS Config Recorder that was created"
  value       = module.aws_config.aws_config_configuration_recorder_id
}

output "iam_role" {
  description = <<-DOC
  IAM Role used to make read or write requests to the delivery channel and to describe the AWS resources associated with
  the account.
  DOC
  value       = module.aws_config.iam_role
}

output "storage_bucket_arn" {
  description = "Bucket ARN"
  value       = module.aws_config_storage.bucket_arn
}

output "storage_bucket_id" {
  description = "Bucket Name (aka ID)"
  value       = module.aws_config_storage.bucket_id
}
