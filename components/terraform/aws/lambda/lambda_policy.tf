# resource "aws_iam_policy" "lambda_s3_access" {
#   count       = local.enabled && var.s3_bucket_access_enabled ? 1 : 0
#   name        = local.policy_name_lambda_s3
#   path        = "/"
#   description = "Policy to allow lambda to access S3"

#   policy = local.policy_json
# }
