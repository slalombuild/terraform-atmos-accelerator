# Outputs for Macie
# These outputs could become public, and we would
# like to avoid unnecessary disclosure of account IDs,
# so use proxies of some kind to validate outputs

output "has_service_role_arn" {
  description = "The service role ARN of the Macie account."
  value       = try(length(module.macie.account_service_role_arn), 0) > 0
}
