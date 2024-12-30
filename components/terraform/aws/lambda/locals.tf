locals {
  custom_iam_policy_arns  = setunion(var.custom_iam_policy_arns, [local.policy_name_lambda_s3_arn])
  enabled                 = module.this.enabled
  example_lambda_artifact = "example-lambda-code.zip"
  # Lambda Config
  function_name = var.function_name != "" ? var.function_name : module.this.id
  lambda_s3_key = var.s3_key == null ? local.example_lambda_artifact : var.s3_key
  policy_arn_prefix = format(
    "arn:%s:iam::%s:policy",
    join("", data.aws_partition.current[*].partition),
    join("", data.aws_caller_identity.current[*].account_id),
  )
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
        Resource = ["arn:aws:s3:::${local.s3_bucket_name}",
        "arn:aws:s3:::${local.s3_bucket_name}/*"]
      },
    ]
  })
  policy_name_lambda_s3     = "${module.this.id}-s3"
  policy_name_lambda_s3_arn = format("%s/%s", local.policy_arn_prefix, local.policy_name_lambda_s3)
  s3_bucket_name            = var.s3_bucket != null ? var.s3_bucket : "${module.this.id}-bucket"
  subnet_ids                = one(data.aws_subnets.private.*.ids)
  vpc_cidr                  = one(data.aws_vpc.main.*.cidr_block)
  vpc_id                    = one(data.aws_vpc.main.*.id)
}