resource "aws_route53_record" "default" {
  count = local.dns_enabled ? 1 : 0

  name    = "${var.route53_record_name}-${var.environment}"
  type    = "A"
  zone_id = local.zone_id

  alias {
    evaluate_target_health = true
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
  }
}

module "alb" {
  source                            = "cloudposse/alb/aws"
  version                           = "2.2.1"
  vpc_id                            = local.vpc_id
  security_group_ids                = local.alb_security_group_id
  subnet_ids                        = local.public_subnet_ids
  internal                          = var.internal
  http_enabled                      = var.http_enabled
  http_redirect                     = var.http_redirect
  http_ingress_cidr_blocks          = var.http_ingress_cidr_blocks
  https_ingress_cidr_blocks         = var.https_ingress_cidr_blocks
  certificate_arn                   = one(data.aws_acm_certificate.default[*].arn)
  access_logs_enabled               = var.access_logs_enabled
  cross_zone_load_balancing_enabled = var.cross_zone_load_balancing_enabled
  http2_enabled                     = var.http2_enabled
  https_enabled                     = var.https_enabled
  https_ssl_policy                  = var.https_ssl_policy
  idle_timeout                      = var.idle_timeout
  ip_address_type                   = var.ip_address_type
  deletion_protection_enabled       = var.deletion_protection_enabled
  deregistration_delay              = var.deregistration_delay
  health_check_path                 = var.health_check_path
  health_check_timeout              = var.health_check_timeout
  health_check_healthy_threshold    = var.health_check_healthy_threshold
  health_check_unhealthy_threshold  = var.health_check_unhealthy_threshold
  health_check_interval             = var.health_check_interval
  health_check_matcher              = var.health_check_matcher
  target_group_name                 = local.target_group_name
  target_group_port                 = var.target_group_port
  target_group_target_type          = var.target_group_target_type
  stickiness                        = var.stickiness

  alb_access_logs_s3_bucket_force_destroy         = var.alb_access_logs_s3_bucket_force_destroy
  alb_access_logs_s3_bucket_force_destroy_enabled = var.alb_access_logs_s3_bucket_force_destroy_enabled

  context = module.this.context
}
