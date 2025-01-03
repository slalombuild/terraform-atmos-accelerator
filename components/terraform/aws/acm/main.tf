# https://github.com/cloudposse/terraform-aws-acm-request-certificate
module "acm" {
  source  = "cloudposse/acm-request-certificate/aws"
  version = "0.18.0"

  validation_method                 = var.validation_method
  domain_name                       = var.domain_name
  process_domain_validation_options = var.process_domain_validation_options
  ttl                               = 300
  subject_alternative_names         = var.subject_alternative_names
  zone_id                           = join("", data.aws_route53_zone.default[*].zone_id)

  context = module.this.context
}

resource "aws_ssm_parameter" "acm_arn" {
  count = local.enabled ? 1 : 0

  name        = "/acm/${var.domain_name}"
  type        = "String"
  description = format("ACM certificate ARN for '%s' domain", var.domain_name)
  overwrite   = true
  tags        = module.this.tags
  value       = module.acm.arn
}
