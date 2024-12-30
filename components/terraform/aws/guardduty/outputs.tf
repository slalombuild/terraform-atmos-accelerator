output "delegated_administrator_account_id" {
  description = "The AWS Account ID of the AWS Organization delegated administrator account"
  value       = local.org_delegated_administrator_account_id
}

output "guardduty_detector_arn" {
  description = "The ARN of the GuardDuty detector created by the component"
  value       = local.create_guardduty_collector ? try(module.guardduty[0].guardduty_detector.arn, null) : null
}

output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector created by the component"
  value       = local.create_guardduty_collector ? try(module.guardduty[0].guardduty_detector.id, null) : null
}

output "sns_topic_name" {
  description = "The name of the SNS topic created by the component"
  value       = local.create_guardduty_collector ? try(module.guardduty[0].sns_topic.name, null) : null
}

output "sns_topic_subscriptions" {
  description = "The SNS topic subscriptions created by the component"
  value       = local.create_guardduty_collector ? try(module.guardduty[0].sns_topic_subscriptions, null) : null
}
