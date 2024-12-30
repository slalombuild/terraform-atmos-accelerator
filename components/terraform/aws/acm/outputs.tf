output "arn" {
  description = "The ARN of the certificate"
  value       = module.acm.arn
}

output "domain_validation_options" {
  description = "CNAME records that are added to the DNS zone to complete certificate validation"
  value       = module.acm.domain_validation_options
}

output "id" {
  description = "The ID of the certificate"
  value       = module.acm.id
}
