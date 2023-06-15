# Cloudwatch component
# https://github.com/cloudposse/terraform-aws-cloudwatch-events
module "sns" {
  source  = "cloudposse/sns-topic/aws"
  version = "0.21.0"

  subscribers = var.sns_topic_subscribers

  allowed_aws_services_for_sns_published = var.sns_topic_allowed_aws_services_for_sns_published

  context = module.this.context
}

module "cloudwatch_event" {
  source  = "cloudposse/cloudwatch-events/aws"
  version = "0.6.1"

  cloudwatch_event_rule_description = var.cloudwatch_event_rule_description
  cloudwatch_event_rule_pattern     = var.cloudwatch_event_rule_pattern
  cloudwatch_event_target_arn       = module.sns.sns_topic.arn

  context = module.this.context
}
