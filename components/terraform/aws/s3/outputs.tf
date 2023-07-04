output "bucket_domain_name" {
  value       = one(module.s3_bucket[*].bucket_domain_name)
  description = "FQDN of bucket"
}

output "bucket_regional_domain_name" {
  value       = one(module.s3_bucket[*].bucket_regional_domain_name)
  description = "The bucket region-specific domain name"
}

output "bucket_website_domain" {
  value       = one(module.s3_bucket[*].bucket_website_domain)
  description = "The bucket website domain, if website is enabled"
}

output "bucket_website_endpoint" {
  value       = one(module.s3_bucket[*].bucket_website_endpoint)
  description = "The bucket website endpoint, if website is enabled"
}

output "bucket_id" {
  value       = one(module.s3_bucket[*].bucket_id)
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = one(module.s3_bucket[*].bucket_arn)
  description = "Bucket ARN"
}

output "bucket_region" {
  value       = one(module.s3_bucket[*].bucket_region)
  description = "Bucket region"
}

output "user_unique_id" {
  value       = one(module.s3_bucket[*].user_unique_id)
  description = "The user unique ID assigned by AWS"
}

output "replication_role_arn" {
  value       = one(module.s3_bucket[*].replication_role_arn)
  description = "The ARN of the replication IAM Role"
}

output "access_key_id" {
  sensitive   = true
  value       = one(module.s3_bucket[*].access_key_id)
  description = "access key output"
}

output "secret_access_key" {
  sensitive   = true
  value       = one(module.s3_bucket[*].secret_access_key)
  description = "secret access key output"
}

output "access_key_id_ssm_path" {
  value       = one(module.s3_bucket[*].access_key_id_ssm_path)
  description = "The SSM Path under which the S3 User's access key ID is stored"
}

output "secret_access_key_ssm_path" {
  value       = one(module.s3_bucket[*].secret_access_key_ssm_path)
  description = "The SSM Path under which the S3 User's secret access key is stored"
}
