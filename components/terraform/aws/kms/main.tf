module "kms_key" {
  source = "cloudposse/kms-key/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version                  = "5.5.0"
  name                     = var.name
  description              = var.description
  user_arn                 = var.user_arn
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  alias                    = var.alias
  policy                   = var.policy
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region
  label_value_case         = var.label_value_case
  labels_as_tags           = var.labels_as_tags

  context = module.this.context
}

