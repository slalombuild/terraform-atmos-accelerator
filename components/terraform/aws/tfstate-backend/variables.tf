variable "region" {
  type        = string
  description = "AWS Region"
}

variable "access_roles" {
  type = map(object({
    write_enabled           = bool
    allowed_roles           = map(list(string))
    denied_roles            = map(list(string))
    allowed_principal_arns  = list(string)
    denied_principal_arns   = list(string)
    allowed_permission_sets = map(list(string))
    denied_permission_sets  = map(list(string))
  }))
  default     = {}
  description = "Map of access roles to create (key is role name, use \"default\" for same as component). See iam-assume-role-policy module for details."
}

variable "access_roles_enabled" {
  type        = bool
  default     = true
  description = "Enable creation of access roles. Set false for cold start (before account-map has been created)."
}

variable "enable_point_in_time_recovery" {
  type        = bool
  default     = true
  description = "Enable DynamoDB point-in-time recovery"
}

variable "enable_server_side_encryption" {
  type        = bool
  default     = true
  description = "Enable DynamoDB and S3 server-side encryption"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates the terraform state S3 bucket can be destroyed even if it contains objects. These objects are not recoverable."
}

variable "prevent_unencrypted_uploads" {
  type        = bool
  default     = true
  description = "Prevent uploads of unencrypted objects to S3"
}
