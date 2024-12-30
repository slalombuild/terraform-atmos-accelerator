data "aws_kms_key" "s3_customer_key" {
  count = local.enabled && var.kms_master_key_id != null ? 1 : 0

  key_id = var.kms_master_key_id
}