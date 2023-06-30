output "s3" {
  description = "output for s3 bucket"
  value = local.enabled ? [for i in module.s3_bucket : {
    bucket_arn    = i.bucket_arn,
    bucket_id     = i.bucket_id,
    bucket_region = i.bucket_region
  }] : null
}
