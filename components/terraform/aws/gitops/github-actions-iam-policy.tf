locals {
  dynamodb_table_arn        = module.dynamodb.outputs.table_arn
  enabled                   = module.this.enabled
  github_actions_iam_policy = data.aws_iam_policy_document.github_actions_iam_policy.json
  s3_bucket_arn             = module.s3_bucket.outputs.bucket_arn
}

data "aws_iam_policy_document" "github_actions_iam_policy" {
  # Allow access to the Dynamodb table used to store TF Plans
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_dynamodb_specific-table.html
  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
    sid = "AllowDynamodbAccess"
  }
  statement {
    actions = [
      "dynamodb:BatchGet*",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWrite*",
      "dynamodb:CreateTable",
      "dynamodb:Delete*",
      "dynamodb:Update*",
      "dynamodb:PutItem"
    ]
    effect = "Allow"
    resources = [
      local.dynamodb_table_arn,
      "${local.dynamodb_table_arn}/*"
    ]
    sid = "AllowDynamodbTableAccess"
  }
  # Allow access to the S3 Bucket used to store TF Plans
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_s3_rw-bucket.html
  statement {
    actions = [
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      local.s3_bucket_arn
    ]
    sid = "AllowS3Actions"
  }
  statement {
    actions = [
      "s3:*Object"
    ]
    effect = "Allow"
    resources = [
      "${local.s3_bucket_arn}/*"
    ]
    sid = "AllowS3ObjectActions"
  }
}
