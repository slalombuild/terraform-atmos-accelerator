locals {
  # The policy name has to be at least 20 characters
  policy_name_lambda_s3 = "${module.this.id}-s3"


  policy_arn_prefix = format(
    "arn:%s:iam::%s:policy",
    join("", data.aws_partition.current[*].partition),
    join("", data.aws_caller_identity.current[*].account_id),
  )
  policy_name_lambda_s3_arn = format("%s/%s", local.policy_arn_prefix, local.policy_name_lambda_s3)

  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:HeadObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
        ]
        Effect = "Allow"
        Resource = ["arn:aws:s3:::${module.lambda_s3_bucket.bucket_id}",
        "arn:aws:s3:::${module.lambda_s3_bucket.bucket_id}/*"]
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_s3_access" {
  name        = local.policy_name_lambda_s3
  path        = "/"
  description = "Policy to allow lambda to access S3"

  policy = local.policy_json
}
