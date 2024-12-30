output "cloudtrail_bucket_arn" {
  description = "CloudTrail S3 bucket ARN"
  value       = module.cloudtrail_s3_bucket.bucket_arn
}

output "cloudtrail_bucket_domain_name" {
  description = "CloudTrail S3 bucket domain name"
  value       = module.cloudtrail_s3_bucket.bucket_domain_name
}

output "cloudtrail_bucket_id" {
  description = "CloudTrail S3 bucket ID"
  value       = module.cloudtrail_s3_bucket.bucket_id
}
