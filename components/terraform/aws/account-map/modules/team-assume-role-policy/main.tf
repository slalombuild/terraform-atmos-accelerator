locals {
  allowed_account_names = compact(concat(
    [for k, v in var.allowed_roles : k if length(v) > 0],
    [for k, v in var.allowed_permission_sets : k if length(v) > 0]
  ))
  allowed_mapped_accounts     = [for acct in local.allowed_account_names : module.allowed_role_map.full_account_map[acct]]
  allowed_principals          = sort(var.allowed_principal_arns)
  allowed_principals_accounts = data.aws_arn.allowed[*].account
  allowed_roles               = concat(module.allowed_role_map.principals, module.allowed_role_map.permission_set_arn_like)
  assume_role_enabled         = (length(local.allowed_mapped_accounts) + length(local.allowed_principals_accounts) + length(local.denied_accounts)) > 0
  aws_partition               = module.allowed_role_map.aws_partition
  denied_accounts             = sort(distinct(concat(local.denied_mapped_accounts, local.denied_arn_accounts)))
  denied_arn_accounts         = data.aws_arn.denied[*].account
  denied_mapped_accounts      = [for acct in concat(keys(var.denied_roles), keys(var.denied_permission_sets)) : module.denied_role_map.full_account_map[acct]]
  denied_principals           = sort(distinct(concat(var.denied_principal_arns, module.denied_role_map.principals, module.denied_role_map.permission_set_arn_like)))
  enabled                     = module.this.enabled
  undenied_principals         = sort(tolist(setsubtract(toset(local.allowed_principals), toset(local.denied_principals))))
}

data "aws_arn" "allowed" {
  count = local.enabled ? length(var.allowed_principal_arns) : 0

  arn = var.allowed_principal_arns[count.index]
}

data "aws_arn" "denied" {
  count = local.enabled ? length(var.denied_principal_arns) : 0

  arn = var.denied_principal_arns[count.index]
}


module "allowed_role_map" {
  source = "../../../account-map/modules/roles-to-principals"

  privileged         = var.privileged
  role_map           = var.allowed_roles
  permission_set_map = var.allowed_permission_sets

  context = module.this.context
}


module "denied_role_map" {
  source = "../../../account-map/modules/roles-to-principals"

  privileged         = var.privileged
  role_map           = var.denied_roles
  permission_set_map = var.denied_permission_sets

  context = module.this.context
}


data "aws_iam_policy_document" "assume_role" {
  count = local.enabled && local.assume_role_enabled ? 1 : 0

  dynamic "statement" {
    for_each = length(local.allowed_mapped_accounts) > 0 && length(local.allowed_roles) > 0 ? ["accounts-roles"] : []

    content {
      actions = [
        "sts:AssumeRole",
        "sts:SetSourceIdentity",
        "sts:TagSession",
      ]
      effect = "Allow"
      sid    = "RoleAssumeRole"

      condition {
        test     = "StringEquals"
        values   = compact(concat(["AssumedRole"], var.iam_users_enabled ? ["User"] : []))
        variable = "aws:PrincipalType"
      }
      condition {
        test     = "ArnLike"
        values   = local.allowed_roles
        variable = "aws:PrincipalArn"
      }
      principals {
        # Principals is a required field, so we allow any principal in any of the accounts, restricted by the assumed Role ARN in the condition clauses.
        # This allows us to allow non-existent (yet to be created) roles, which would not be allowed if directly specified in `principals`.
        identifiers = formatlist("arn:${local.aws_partition}:iam::%s:root", local.allowed_mapped_accounts)
        type        = "AWS"
      }
    }
  }
  dynamic "statement" {
    for_each = length(local.allowed_principals_accounts) > 0 && length(local.allowed_principals) > 0 ? ["accounts-principals"] : []

    content {
      actions = [
        "sts:AssumeRole",
        "sts:SetSourceIdentity",
        "sts:TagSession",
      ]
      effect = "Allow"
      sid    = "PrincipalAssumeRole"

      condition {
        test     = "ArnLike"
        values   = local.allowed_principals
        variable = "aws:PrincipalArn"
      }
      principals {
        # Principals is a required field, so we allow any principal in any of the accounts, restricted by the assumed Role ARN in the condition clauses.
        # This allows us to allow non-existent (yet to be created) roles, which would not be allowed if directly specified in `principals`.
        identifiers = formatlist("arn:${local.aws_partition}:iam::%s:root", local.allowed_principals_accounts)
        type        = "AWS"
      }
    }
  }
  # As a safety measure, we do not allow AWS Users (not Roles) to assume the SAML Teams or Team roles
  # unless `deny_all_iam_users` is explicitly set to `false` or the user is explicitly allowed.
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:SetSourceIdentity",
      "sts:TagSession",
    ]
    effect = "Deny"
    sid    = "RoleDenyAssumeRole"

    condition {
      test = "ArnLike"
      values = compact(concat(local.denied_principals, var.iam_users_enabled ? [] : [
        "arn:${local.aws_partition}:iam::*:user/*"
      ]))
      variable = "aws:PrincipalArn"
    }
    dynamic "condition" {
      for_each = length(local.undenied_principals) > 0 ? ["exceptions"] : []

      content {
        test     = "ArnNotEquals"
        values   = local.undenied_principals
        variable = "aws:PrincipalArn"
      }
    }
    principals {
      # Principals is a required field, so we allow any principal in any of the accounts, restricted by the assumed Role ARN in the condition clauses.
      # This allows us to allow non-existent (yet to be created) roles, which would not be allowed if directly specified in `principals`.
      # We also deny all directly logged-in users from all the enabled accounts.
      identifiers = formatlist("arn:${local.aws_partition}:iam::%s:root", sort(distinct(concat(local.denied_accounts, local.allowed_mapped_accounts, local.allowed_principals_accounts))))
      # By specifying type "AWS", this DENY policy will not apply to AWS Services or EKS' OIDC.
      type = "AWS"
    }
  }
}
