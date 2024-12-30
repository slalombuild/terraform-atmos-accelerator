output "delegated_administrator_account_id" {
  description = "The AWS Account ID of the AWS Organization delegated administrator account"
  value       = local.org_delegated_administrator_account_id
}

output "sns_topic_name" {
  description = "The name of the SNS topic created by the component"
  value       = local.create_securityhub ? try(module.security_hub[0].sns_topic.name, null) : null
}

output "sns_topic_subscriptions" {
  description = "The SNS topic subscriptions created by the component"
  value       = local.create_securityhub ? try(module.security_hub[0].sns_topic_subscriptions, null) : null
}
