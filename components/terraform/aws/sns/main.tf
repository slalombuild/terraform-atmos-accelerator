# SNS component
# https://github.com/cloudposse/terraform-aws-sns-topic
module "sns" {
  source  = "cloudposse/sns-topic/aws"
  version = "1.1.0"

  allowed_aws_services_for_sns_published = var.allowed_aws_services_for_sns_published

  sqs_dlq_enabled    = true
  fifo_topic         = true
  fifo_queue_enabled = true

  context = module.this.context
}
