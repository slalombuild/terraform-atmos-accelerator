locals {
  identity_account_id = local.full_account_map[module.account_map.outputs.identity_account_account_name]
}

data "aws_iam_policy_document" "team_role_access" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:SetSourceIdentity",
      "sts:TagSession",
    ]
    effect = "Allow"
    resources = [
      "arn:${local.aws_partition}:iam::*:role/*",
    ]
    sid = "TeamRoleAccess"
  }
  statement {
    actions   = ["sts:GetCallerIdentity"]
    effect    = "Allow"
    resources = ["*"]
    sid       = "GetCallerIdentity"
  }
}

resource "aws_iam_policy" "team_role_access" {
  policy      = data.aws_iam_policy_document.team_role_access.json
  description = "IAM permission to use AssumeRole"
  name        = format("%s-TeamRoleAccess", module.this.id)
  tags        = module.this.tags
}
