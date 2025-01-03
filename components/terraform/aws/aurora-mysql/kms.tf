module "kms_key_rds" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.2"

  description             = "KMS key for Aurora MySQL"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy                  = join("", data.aws_iam_policy_document.kms_key_rds.*.json)

  context = module.cluster.context
}

data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

# https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-administrators
# https://aws.amazon.com/premiumsupport/knowledge-center/update-key-policy-future/
data "aws_iam_policy_document" "kms_key_rds" {
  count = local.enabled ? 1 : 0

  statement {
    actions = [
      "kms:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
    sid = "Enable the account that owns the KMS key to manage it via IAM"

    principals {
      identifiers = [
        format("arn:${join("", data.aws_partition.current.*.partition)}:iam::%s:root", join("", data.aws_caller_identity.current.*.account_id))
      ]
      type = "AWS"
    }
  }
  # https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html
  # https://docs.aws.amazon.com/efs/latest/ug/using-service-linked-roles.html
  statement {
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
      "kms:CreateGrant"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
    sid = "Allow RDS to encrypt and decrypt with the KMS key"

    principals {
      identifiers = [
        "rds.amazonaws.com"
      ]
      type = "Service"
    }
  }
}
