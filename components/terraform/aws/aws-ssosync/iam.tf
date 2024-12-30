
data "aws_iam_policy_document" "ssosync_lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "ssosync_lambda_identity_center" {
  statement {
    actions = [
      "identitystore:DeleteUser",
      "identitystore:CreateGroup",
      "identitystore:CreateGroupMembership",
      "identitystore:ListGroups",
      "identitystore:ListUsers",
      "identitystore:ListGroupMemberships",
      "identitystore:IsMemberInGroups",
      "identitystore:GetGroupMembershipId",
      "identitystore:DeleteGroupMembership",
      "identitystore:DeleteGroup",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role" "default" {
  count = local.enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.ssosync_lambda_assume_role.json
  name               = module.this.id

  inline_policy {
    name   = "ssosync_lambda_identity_center"
    policy = data.aws_iam_policy_document.ssosync_lambda_identity_center.json
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  count = local.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.default[0].name
}
