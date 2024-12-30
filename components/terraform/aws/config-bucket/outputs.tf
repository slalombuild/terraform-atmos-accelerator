output "config_bucket_arn" {
  description = "Config bucket ARN"
  value       = module.config_bucket.bucket_arn
}

output "config_bucket_domain_name" {
  description = "Config bucket FQDN"
  value       = module.config_bucket.bucket_domain_name
}

output "config_bucket_id" {
  description = "Config bucket ID"
  value       = module.config_bucket.bucket_id
}
