variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "global_resource_collector_region" {
  type        = string
  description = "The region that collects AWS Config data for global resources such as IAM"
}

# Variables for config
variable "region" {
  type        = string
  description = "AWS Region"
}

variable "create_iam_role" {
  type        = bool
  default     = false
  description = "Flag to indicate whether an IAM Role should be created to grant the proper permissions for AWS Config"
}

variable "create_sns_topic" {
  type        = bool
  default     = false
  description = <<-DOC
    Flag to indicate whether an SNS topic should be created for notifications
    If you want to send findings to a new SNS topic, set this to true and provide a valid configuration for subscribers
  DOC
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
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
  DOC
}
