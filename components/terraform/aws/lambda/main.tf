# Lambda s3 access to download artifacts
module "lambda_s3_bucket" {
  source                  = "cloudposse/s3-bucket/aws"
  version                 = "3.1.3"
  enabled                 = var.s3_bucket == null ? true : false
  bucket_name             = module.this.id
  attributes              = ["bucket"]
  allow_ssl_requests_only = true
  acl                     = "private"
  versioning_enabled      = true

  context = module.this.context
}

resource "aws_iam_policy" "lambda_s3_access" {
  count = local.enabled && var.s3_bucket_access_enabled ? 1 : 0

  policy      = local.policy_json
  description = "Policy to allow lambda to access S3"
  name        = local.policy_name_lambda_s3
  path        = "/"
}

# Security group when using vpc_config
resource "aws_security_group" "lambda_sg" {
  count = local.enabled && var.default_sg_enabled ? 1 : 0

  description = "Lambda egress SG"
  name        = module.this.id
  vpc_id      = local.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "lambda_egress" {
  count = local.enabled && var.default_sg_enabled ? 1 : 0

  from_port         = 0
  protocol          = "all"
  security_group_id = one(aws_security_group.lambda_sg.*.id)
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = [local.vpc_cidr]
  description       = "Lambda egress"
}

module "lambda_function" {
  source  = "cloudposse/lambda-function/aws"
  version = "0.5.1"

  s3_bucket                          = var.s3_bucket
  s3_key                             = var.s3_key
  s3_object_version                  = var.s3_object_version
  function_name                      = local.function_name
  handler                            = var.handler
  runtime                            = var.runtime
  tracing_config_mode                = var.tracing_config_mode
  timeout                            = var.timeout
  cloudwatch_lambda_insights_enabled = var.cloudwatch_lambda_insights_enabled
  cloudwatch_logs_retention_in_days  = var.cloudwatch_logs_retention_in_days
  cloudwatch_logs_kms_key_arn        = var.cloudwatch_logs_kms_key_arn
  custom_iam_policy_arns             = local.custom_iam_policy_arns
  architectures                      = var.architectures
  description                        = var.description
  filename                           = var.filename
  image_config                       = var.image_config
  image_uri                          = var.image_uri
  kms_key_arn                        = var.kms_key_arn
  lambda_at_edge_enabled             = var.lambda_at_edge_enabled
  layers                             = var.layers
  memory_size                        = var.memory_size
  package_type                       = var.package_type
  permissions_boundary               = var.permissions_boundary
  publish                            = var.publish
  reserved_concurrent_executions     = var.reserved_concurrent_executions
  source_code_hash                   = var.source_code_hash
  ssm_parameter_names                = var.ssm_parameter_names
  dead_letter_config_target_arn      = var.dead_letter_config_target_arn
  iam_policy_description             = var.iam_policy_description
  lambda_environment                 = var.lambda_environment
  ephemeral_storage_size             = var.ephemeral_storage_size

  vpc_config = var.default_sg_enabled ? {
    security_group_ids = [one(aws_security_group.lambda_sg.*.id)]
    subnet_ids         = local.subnet_ids
  } : var.vpc_config

  context = module.this.context
}

# Uploading lambda artifact to S3
# if no package_name is provider we will upload a hello world example lambda package
# to the created s3 bucket to be able to create the lambda function.
resource "aws_s3_bucket_object" "lambda_zip" {
  count = local.enabled && var.s3_bucket != null && var.filename != "" ? 0 : 1

  bucket       = one(module.lambda_s3_bucket.*.bucket_id)
  key          = module.this.id
  content_type = "application/zip"
  etag         = filemd5(local.example_lambda_artifact)
  source       = "${path.module}/${local.example_lambda_artifact}"
}
