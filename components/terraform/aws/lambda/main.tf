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
  version = "0.5.3"

  s3_bucket                          = module.lambda_s3_bucket.bucket_id
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
  source  = "cloudposse/s3-bucket/aws"
  version = "4.0.1"

  bucket_name             = module.this.id
  allow_ssl_requests_only = true
  acl                     = "private"
  versioning_enabled      = true

  context = module.this.context
}

# Uploading lambda artifact to S3
resource "aws_s3_bucket_object" "lambda_zip" {
  bucket       = module.lambda_s3_bucket.bucket_id
  key          = local.lambda_s3_key
  source       = "${path.module}/${local.package_name}"
  content_type = "application/zip"
  etag         = filemd5(local.package_name)
}
