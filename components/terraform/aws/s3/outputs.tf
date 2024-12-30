output "access_key_id" {
  description = "access key output"
  sensitive   = true
  value       = one(module.s3_bucket[*].access_key_id)
}

output "access_key_id_ssm_path" {
  description = "The SSM Path under which the S3 User's access key ID is stored"
  value       = one(module.s3_bucket[*].access_key_id_ssm_path)
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = one(module.s3_bucket[*].bucket_arn)
}

output "bucket_domain_name" {
  description = "FQDN of bucket"
  value       = one(module.s3_bucket[*].bucket_domain_name)
}

output "bucket_id" {
  description = "Bucket Name (aka ID)"
  value       = one(module.s3_bucket[*].bucket_id)
}

output "bucket_region" {
  description = "Bucket region"
  value       = one(module.s3_bucket[*].bucket_region)
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = one(module.s3_bucket[*].bucket_regional_domain_name)
}

output "bucket_website_domain" {
  description = "The bucket website domain, if website is enabled"
  value       = one(module.s3_bucket[*].bucket_website_domain)
}

output "bucket_website_endpoint" {
  description = "The bucket website endpoint, if website is enabled"
  value       = one(module.s3_bucket[*].bucket_website_endpoint)
}

output "replication_role_arn" {
  description = "The ARN of the replication IAM Role"
  value       = one(module.s3_bucket[*].replication_role_arn)
}

output "secret_access_key" {
  description = "secret access key output"
  sensitive   = true
  value       = one(module.s3_bucket[*].secret_access_key)
}

output "secret_access_key_ssm_path" {
  description = "The SSM Path under which the S3 User's secret access key is stored"
  value       = one(module.s3_bucket[*].secret_access_key_ssm_path)
}

output "user_unique_id" {
  description = "The user unique ID assigned by AWS"
  value       = one(module.s3_bucket[*].user_unique_id)
}
