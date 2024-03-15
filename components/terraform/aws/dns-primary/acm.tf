variable "request_acm_certificate" {
  type        = bool
  description = "Whether or not to request an ACM certificate for each domain"
  default     = false
}

module "acm" {
  for_each = local.domains_set

  source  = "cloudposse/acm-request-certificate/aws"
  version = "0.18.0"

  enabled = local.certificate_enabled

  domain_name                       = each.value
  process_domain_validation_options = true
  ttl                               = 300
  subject_alternative_names         = [format("*.%s", each.value)]

  context    = module.this.context
  depends_on = [aws_route53_record.soa]
}
