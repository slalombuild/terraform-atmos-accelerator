# Outputs for Cloudwatch
output "aws_cloudwatch_event_rule_id" {
  description = "The name of the rule"
  value       = module.cloudwatch_event.aws_cloudwatch_event_rule_id
}

output "aws_cloudwatch_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = module.cloudwatch_event.aws_cloudwatch_event_rule_arn
}
