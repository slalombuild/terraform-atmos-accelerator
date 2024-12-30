variable "central_resource_collector_account" {
  type        = string
  description = "The name of the account that is the centralized aggregation account."
}

variable "config_bucket_env" {
  type        = string
  description = "The environment of the AWS Config S3 Bucket"
}

variable "config_bucket_stage" {
  type        = string
  description = "The stage of the AWS Config S3 Bucket"
}

variable "global_resource_collector_region" {
  type        = string
  description = "The region that collects AWS Config data for global resources such as IAM"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "account_map_tenant" {
  type        = string
  default     = ""
  description = "(Optional) The tenant where the account_map component required by remote-state is deployed."
}

variable "az_abbreviation_type" {
  type        = string
  default     = "fixed"
  description = "AZ abbreviation type, `fixed` or `short`"
}

variable "config_bucket_tenant" {
  type        = string
  default     = ""
  description = "(Optional) The tenant of the AWS Config S3 Bucket"
}

variable "conformance_packs" {
  type = list(object({
    name                = string
    conformance_pack    = string
    parameter_overrides = map(string)
  }))
  default     = []
  description = <<-DOC
    List of conformance packs. Each conformance pack is a map with the following keys: name, conformance_pack, parameter_overrides.

    For example:
    conformance_packs = [
      {
        name                  = "Operational-Best-Practices-for-CIS-AWS-v1.4-Level1"
        conformance_pack      = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/Operational-Best-Practices-for-CIS-AWS-v1.4-Level1.yaml"
        parameter_overrides   = {
          "AccessKeysRotatedParamMaxAccessKeyAge" = "45"
        }
      },
      {
        name                  = "Operational-Best-Practices-for-CIS-AWS-v1.4-Level2"
        conformance_pack      = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/Operational-Best-Practices-for-CIS-AWS-v1.4-Level2.yaml"
        parameter_overrides   = {
          "IamPasswordPolicyParamMaxPasswordAge" = "45"
        }
      }
    ]

    Complete list of AWS Conformance Packs managed by AWSLabs can be found here:
    https://github.com/awslabs/aws-config-rules/tree/master/aws-config-conformance-packs
  DOC
}

variable "create_iam_role" {
  type        = bool
  default     = false
  description = "Flag to indicate whether an IAM Role should be created to grant the proper permissions for AWS Config"
}

variable "delegated_accounts" {
  type        = set(string)
  default     = null
  description = "The account IDs of other accounts that will send their AWS Configuration or Security Hub data to this account"
}

variable "global_environment" {
  type        = string
  default     = "gbl"
  description = "Global environment name"
}

variable "iam_role_arn" {
  type        = string
  default     = null
  description = <<-DOC
    The ARN for an IAM Role AWS Config uses to make read or write requests to the delivery channel and to describe the
    AWS resources associated with the account. This is only used if create_iam_role is false.

    If you want to use an existing IAM Role, set the variable to the ARN of the existing role and set create_iam_role to `false`.

    See the AWS Docs for further information:
    http://docs.aws.amazon.com/config/latest/developerguide/iamrole-permissions.html
  DOC
}

variable "iam_roles_environment_name" {
  type        = string
  default     = "gbl"
  description = "The name of the environment where the IAM roles are provisioned"
}

variable "managed_rules" {
  type = map(object({
    description      = string
    identifier       = string
    input_parameters = any
    tags             = map(string)
    enabled          = bool
  }))
  default     = {}
  description = <<-DOC
    A list of AWS Managed Rules that should be enabled on the account.

    See the following for a list of possible rules to enable:
    https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html

    Example:
    ```
    managed_rules = {
      access-keys-rotated = {
        identifier  = "ACCESS_KEYS_ROTATED"
        description = "Checks whether the active access keys are rotated within the number of days specified in maxAccessKeyAge. The rule is NON_COMPLIANT if the access keys have not been rotated for more than maxAccessKeyAge number of days."
        input_parameters = {
          maxAccessKeyAge : "90"
        }
        enabled = true
        tags = {}
      }
    }
    ```
  DOC
}

variable "privileged" {
  type        = bool
  default     = false
  description = "True if the default provider already has access to the backend"
}

variable "root_account_stage" {
  type        = string
  default     = "root"
  description = "The stage name for the Organization root (master) account"
}
