# Outputs for guardduty
output "guardduty_detector" {
  value = module.guardduty.guardduty_detector
}
output "sns_topic" {
  value = module.guardduty.sns_topic
}
