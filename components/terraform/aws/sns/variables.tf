# Variables for SNS
variable "region" {
  type        = string
  description = "AWS region"
}

variable "allowed_aws_services_for_sns_published" {
  type        = list(string)
  description = "AWS services that will have permission to publish to SNS topic. Used when no external JSON policy is used"
  default     = []
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}
