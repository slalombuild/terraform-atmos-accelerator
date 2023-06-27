module "kms_key" {
  source = "cloudposse/kms-key/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version                  = ">= 0.13"
  namespace                = var.namespace
  name                     = module.this.id
  description              = var.description
  user_arn                 = var.user_arn
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  enabled                  = var.enabled
  alias                    = var.alias
  policy                   = var.policy
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region
  tags                     = var.tags
  label_value_case         = var.label_value_case
  labels_as_tags           = var.labels_as_tags
  stage                    = var.stage
  environment              = var.environment
  delimiter                = var.delimiter
  attributes               = var.attributes
  additional_tag_map       = var.additional_tag_map
  regex_replace_chars      = var.regex_replace_chars
  label_order              = var.label_order
  id_length_limit          = var.id_length_limit
  label_key_case           = var.label_key_case
  descriptor_formats       = var.descriptor_formats

  context = module.this.context
}
