output "arn" {
  description = "The ARN of the WAF WebACL."
  value       = module.waf.arn
}

output "capacity" {
  description = "The web ACL capacity units (WCUs) currently being used by this web ACL."
  value       = module.waf.capacity
}

# Outputs for WAF
output "id" {
  description = "The ID of the WAF WebACL."
  value       = module.waf.id
}
