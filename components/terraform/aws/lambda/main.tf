locals {
  enabled    = module.this.enabled
  region     = var.region
  vpc_id     = data.aws_vpc.main.id
  subnet_ids = data.aws_subnets.private.ids
  vpc_cidr   = data.aws_vpc.main.cidr_block
  account_id = join("", data.aws_caller_identity.current[*].account_id)
  # Lambda Config
  lambda_s3_key = var.s3_key == null ? var.package_name : var.s3_key
  package_name  = var.package_name
  s3_bucket     = var.s3_bucket_name != "" ? var.s3_bucket_name : module.lambda_s3_bucket[0].bucket_id
}

resource "aws_security_group" "lambda_sg" {
  name        = module.this.id
  vpc_id      = local.vpc_id
  description = "Lambda egress SG"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "lambda_egress" {
  security_group_id = aws_security_group.lambda_sg.id
  description       = "cicd"
  cidr_blocks       = [local.vpc_cidr]
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  type              = "egress"
}

module "lambda_function" {
  source  = "cloudposse/lambda-function/aws"
  version = "0.5.0"

  s3_bucket                          = local.s3_bucket
  s3_key                             = local.lambda_s3_key
  function_name                      = module.this.id
  handler                            = var.handler
  runtime                            = var.runtime
  tracing_config_mode                = "Active"
  timeout                            = 300
  cloudwatch_lambda_insights_enabled = true
  custom_iam_policy_arns             = [local.policy_name_lambda_s3_arn]

  lambda_environment = var.lambda_environment

  vpc_config = {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = local.subnet_ids
  }

  depends_on = [
    aws_iam_policy.lambda_s3_access,
  ]

  context = module.this.context
}

module "lambda_s3_bucket" {
  count   = var.s3_bucket_name != "" ? 0 : 1
  source  = "cloudposse/s3-bucket/aws"
  version = "4.0.0"

  bucket_name             = module.this.id
  allow_ssl_requests_only = true
  acl                     = "private"
  versioning_enabled      = true

  context = module.this.context
}

# Uploading lambda artifact to S3
resource "aws_s3_bucket_object" "lambda_zip" {
  count        = var.s3_bucket_name != "" ? 0 : 1
  bucket       = module.lambda_s3_bucket[count.index].bucket_id
  key          = local.lambda_s3_key
  source       = "${path.module}/${local.package_name}"
  content_type = "application/zip"
  etag         = filemd5(local.package_name)
}
