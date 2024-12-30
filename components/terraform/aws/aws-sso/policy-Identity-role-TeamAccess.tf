
# This file generates a permission set for each role specified in var.target_identity_roles
# which is named "Identity<Role>TeamAccess" and grants access to only that role,
# plus ViewOnly access because it is difficult to navigate without any access at all.

data "aws_iam_policy_document" "assume_aws_team" {
  for_each = local.enabled ? var.aws_teams_accessible : []

  statement {
    actions = [
      "sts:AssumeRole",
      "sts:SetSourceIdentity",
      "sts:TagSession",
    ]
    effect    = "Allow"
    resources = ["*"]
    sid       = "RoleAssumeRole"
  }
}

module "role_map" {
  source = "../account-map/modules/roles-to-principals"

  teams      = var.aws_teams_accessible
  privileged = var.privileged

  context = module.this.context
}

locals {
  identity_access_permission_sets = [for role in var.aws_teams_accessible : {
    name                                = module.role_map.team_permission_set_name_map[role],
    description                         = format("Allow user to assume the %s Team role in the Identity account, which allows access to other accounts", replace(title(role), "-", ""))
    relay_state                         = "",
    session_duration                    = "",
    tags                                = {},
    inline_policy                       = data.aws_iam_policy_document.assume_aws_team[role].json
    policy_attachments                  = ["arn:${local.aws_partition}:iam::aws:policy/job-function/ViewOnlyAccess"]
    customer_managed_policy_attachments = []
  }]
}
