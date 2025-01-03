module "flow_logs" {
  version          = "1.3.0"
  source           = "cloudposse/vpc-flow-logs-s3-bucket/aws"
  flow_log_enabled = var.flow_log_enabled
  enabled          = var.flow_log_enabled

  vpc_id = module.vpc.vpc_id

  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days
  glacier_transition_days            = var.glacier_transition_days
  expiration_days                    = var.expiration_days
  traffic_type                       = var.traffic_type
  allow_ssl_requests_only            = var.allow_ssl_requests_only

  force_destroy = true

  context = module.this.context
}
