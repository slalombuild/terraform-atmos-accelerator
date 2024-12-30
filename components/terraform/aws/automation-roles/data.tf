# The custom Admin policy to attach to the automation role in each account instead of the managed AdminAccess policy
data "aws_iam_policy_document" "AdministratorAccess" {
  provider = aws.auto

  statement {
    effect = "Allow"
    not_actions = [
      "organizations:*",
      "account:*"
    ]
    resources = ["*"]
    sid       = "AutomationAdmin"
  }
  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:DeleteServiceLinkedRole",
      "iam:ListRoles",
      "organizations:DescribeOrganization",
      "account:ListRegions"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

# The assume assume role policy for the automation role in the automation account.
# This is used to attache to the Atlantis task role as well
data "aws_iam_policy_document" "assume_role_policy" {
  provider = aws.auto

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    resources = compact([
      local.automation_user_admin_role_arn,
      local.dev_user_admin_role_arn,
      local.staging_user_admin_role_arn,
      local.prod_user_admin_role_arn
    ])
    sid = "AssumeAccounts"
  }
}
