output "vpc_flow_logs_bucket_arn" {
  description = "VPC Flow Logs bucket ARN"
  value       = module.flow_logs_s3_bucket.bucket_arn
}

output "vpc_flow_logs_bucket_id" {
  description = "VPC Flow Logs bucket ID"
  value       = module.flow_logs_s3_bucket.bucket_id
}
