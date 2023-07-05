variable "region" {
  type        = string
  description = "AWS Region"
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates the terraform state S3 bucket can be destroyed even if it contains objects. These objects are not recoverable."
  default     = false
}

variable "prevent_unencrypted_uploads" {
  type        = bool
  description = "Prevent uploads of unencrypted objects to S3"
  default     = true
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable DynamoDB point-in-time recovery"
  default     = false
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}
