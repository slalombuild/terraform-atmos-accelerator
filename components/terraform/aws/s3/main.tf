module "s3_bucket" {
  count                                   = local.enabled ? 1 : 0
  source                                  = "cloudposse/s3-bucket/aws"
  version                                 = "4.0.1"
  block_public_acls                       = var.block_public_acls
  block_public_policy                     = var.block_public_policy
  ignore_public_acls                      = var.ignore_public_acls
  restrict_public_buckets                 = var.restrict_public_buckets
  versioning_enabled                      = var.versioning_enabled
  bucket_key_enabled                      = var.bucket_key_enabled
  kms_master_key_arn                      = var.kms_master_key_id != null ? data.aws_kms_key.s3_customer_key[0].arn : var.kms_master_key_id
  bucket_name                             = module.this.id
  access_key_enabled                      = var.access_key_enabled
  acl                                     = "private"
  allow_encrypted_uploads_only            = var.allow_encrypted_uploads_only
  allowed_bucket_actions                  = var.allowed_bucket_actions
  cors_configuration                      = var.cors_configuration
  logging                                 = var.logging
  object_lock_configuration               = var.object_lock_configuration
  privileged_principal_actions            = var.privileged_principal_actions
  privileged_principal_arns               = var.privileged_principal_arns
  s3_object_ownership                     = var.s3_object_ownership
  s3_replica_bucket_arn                   = var.s3_replica_bucket_arn
  s3_replication_enabled                  = var.s3_replication_enabled
  s3_replication_permissions_boundary_arn = var.s3_replication_permissions_boundary_arn
  s3_replication_rules                    = var.s3_replication_rules
  s3_replication_source_roles             = var.s3_replication_source_roles
  sse_algorithm                           = var.sse_algorithm
  source_policy_documents                 = var.source_policy_documents
  ssm_base_path                           = var.ssm_base_path
  store_access_key_in_ssm                 = var.store_access_key_in_ssm
  user_permissions_boundary_arn           = var.user_permissions_boundary_arn
  website_configuration                   = var.website_configuration
  lifecycle_configuration_rules           = var.lifecycle_configuration_rules
  context                                 = module.this.context
}
