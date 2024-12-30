output "bucket_arn" {
  description = "Bucket ARN"
  value       = module.s3_bucket.bucket_arn
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = module.s3_bucket.bucket_domain_name
}

output "bucket_id" {
  description = "Bucket ID"
  value       = module.s3_bucket.bucket_id
}

output "bucket_region" {
  description = "Bucket region"
  value       = module.s3_bucket.bucket_region
}

output "bucket_regional_domain_name" {
  description = "Bucket region-specific domain name"
  value       = module.s3_bucket.bucket_regional_domain_name
}
