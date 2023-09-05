# Guardduty component
module "guardduty" {
  version = "0.5.0"
  source  = "cloudposse/guardduty/aws"

  create_sns_topic = var.create_sns_topic

  context = module.this.context
}
