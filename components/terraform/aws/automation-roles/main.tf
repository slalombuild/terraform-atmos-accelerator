# The remote backend in the automation account
module "terraform_state_backend" {
  source      = "cloudposse/tfstate-backend/aws"
  version     = "1.1.1"
  enabled     = true
  namespace   = "accelerator-auto"
  environment = "ue2"
  name        = "tfstate"
  attributes  = compact(["iac", var.project_name])

  prevent_unencrypted_uploads = true
  force_destroy               = false

  providers = {
    aws = aws.auto
  }
  tags = module.this.tags
}

resource "aws_iam_policy" "allow_automation_tasks_to_assume" {
  count       = module.this.enabled ? 1 : 0
  name        = "allow_automation_tasks_to_assume"
  description = "Policy used for atlantis to be permitted to assume roles"
  policy      = one([data.aws_iam_policy_document.assume_role_policy[*].json])
  provider    = aws.auto
  tags        = module.this.tags
}

resource "aws_iam_role_policy_attachment" "allow_automation_tasks_to_assume" {
  role       = var.iac_automation_role_name
  policy_arn = one([aws_iam_policy.allow_automation_tasks_to_assume[*].arn])
  provider   = aws.auto
}

# The accelerator automation role definitions
module "automation_auto_role" {
  source      = "cloudposse/iam-role/aws"
  version     = "0.18.0"
  enabled     = module.this.enabled
  namespace   = "accelerator-auto"
  environment = "automation"
  name        = "role"

  policy_description = "Allow Automation admin for IaC"
  role_description   = "IAM role with permissions to perform actions on all resources"

  principals = {
    AWS = compact([
      var.iac_automation_role_arn,
      local.dev_user_admin_role_arn,
      local.staging_user_admin_role_arn,
      local.prod_user_admin_role_arn
    ])
  }

  policy_documents = [
    data.aws_iam_policy_document.AdministratorAccess.json,
    data.aws_iam_policy_document.assume_role_policy.json
  ]
  providers = {
    aws = aws.auto
  }
  tags = module.this.tags
}

module "automation_dev_role" {
  source      = "cloudposse/iam-role/aws"
  version     = "0.18.0"
  enabled     = lookup(var.accounts, "dev", null) != null ? true : false
  namespace   = "accelerator-dev"
  environment = "automation"
  name        = "role"

  policy_description = "Allow Automation admin for IaC"
  role_description   = "IAM role with permissions to perform actions on all resources"

  principals = {
    AWS = [
      module.automation_auto_role.arn,
      var.iac_automation_role_arn
    ]
  }

  policy_documents = [
    data.aws_iam_policy_document.AdministratorAccess.json
  ]
  providers = {
    aws = aws.dev
  }
  tags = module.this.tags
}

module "automation_staging_role" {
  source      = "cloudposse/iam-role/aws"
  version     = "0.18.0"
  enabled     = lookup(var.accounts, "staging", null) != null ? true : false
  namespace   = "accelerator-staging"
  environment = "automation"
  name        = "role"

  policy_description = "Allow Automation admin for IaC"
  role_description   = "IAM role with permissions to perform actions on all resources"

  principals = {
    AWS = [
      module.automation_auto_role.arn,
      var.iac_automation_role_arn
    ]
  }

  policy_documents = [
    data.aws_iam_policy_document.AdministratorAccess.json
  ]
  providers = {
    aws = aws.staging
  }
  tags = module.this.tags
}

module "automation_prod_role" {
  source      = "cloudposse/iam-role/aws"
  version     = "0.18.0"
  enabled     = lookup(var.accounts, "prod", null) != null ? true : false
  namespace   = "accelerator-prod"
  environment = "automation"
  name        = "role"

  policy_description = "Allow Automation admin for IaC"
  role_description   = "IAM role with permissions to perform actions on all resources"

  principals = {
    AWS = [
      module.automation_auto_role.arn,
      var.iac_automation_role_arn
    ]
  }

  policy_documents = [
    data.aws_iam_policy_document.AdministratorAccess.json
  ]
  providers = {
    aws = aws.prod
  }
  tags = module.this.tags
}
