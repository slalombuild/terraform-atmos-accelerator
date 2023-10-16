module "dynamodb" {
  source  = "cloudposse/dynamodb/aws"
  version = "v0.34.0"

  enabled                            = local.enabled
  autoscale_write_target             = var.autoscale_write_target
  autoscale_read_target              = var.autoscale_read_target
  autoscale_min_read_capacity        = var.autoscale_min_read_capacity
  autoscale_max_read_capacity        = var.autoscale_max_read_capacity
  autoscale_min_write_capacity       = var.autoscale_min_write_capacity
  autoscale_max_write_capacity       = var.autoscale_max_write_capacity
  billing_mode                       = var.billing_mode
  enable_streams                     = var.enable_streams
  stream_view_type                   = var.stream_view_type
  enable_encryption                  = var.enable_encryption
  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn
  enable_point_in_time_recovery      = var.enable_point_in_time_recovery
  hash_key                           = var.hash_key
  hash_key_type                      = var.hash_key_type
  range_key                          = var.range_key
  range_key_type                     = var.range_key_type
  ttl_attribute                      = var.ttl_attribute
  ttl_enabled                        = var.ttl_enabled
  enable_autoscaler                  = var.enable_autoscaler
  autoscaler_attributes              = var.autoscaler_attributes
  autoscaler_tags                    = var.autoscaler_tags
  dynamodb_attributes                = var.dynamodb_attributes
  global_secondary_index_map         = var.global_secondary_index_map
  local_secondary_index_map          = var.local_secondary_index_map
  replicas                           = var.replicas
  tags_enabled                       = var.tags_enabled
  table_class                        = var.table_class
  deletion_protection_enabled        = var.deletion_protection_enabled


  context = module.this.context
}