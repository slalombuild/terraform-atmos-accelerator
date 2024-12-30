variable "google_admin_email" {
  type        = string
  description = "Google Admin email"
}

variable "region" {
  type        = string
  description = "AWS Region where AWS SSO is enabled"
}

variable "architecture" {
  type        = string
  default     = "x86_64"
  description = "Architecture of the Lambda function"
}

variable "cloudwatch_lambda_insights_enabled" {
  type        = bool
  default     = false
  description = "Enable CloudWatch Lambda Insights for the Lambda Function."
}

variable "cloudwatch_logs_kms_key_arn" {
  type        = string
  default     = null
  description = "The ARN of the KMS Key to use when encrypting log data."
}

variable "cloudwatch_logs_retention_in_days" {
  type        = number
  default     = null
  description = <<EOF
  Specifies the number of days you want to retain log events in the specified log group. Possible values are:
  1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the
  log group are always retained and never expire.
  EOF
}

variable "google_credentials_ssm_path" {
  type        = string
  default     = "/ssosync"
  description = "SSM Path for `ssosync` secrets"
}

variable "google_group_match" {
  type        = string
  default     = ""
  description = "Google Workspace group filter query parameter, example: 'name:Admin* email:aws-*', see: https://developers.google.com/admin-sdk/directory/v1/guides/search-groups"
}

variable "google_user_match" {
  type        = string
  default     = ""
  description = "Google Workspace user filter query parameter, example: 'name:John* email:admin*', see: https://developers.google.com/admin-sdk/directory/v1/guides/search-users"
}

variable "ignore_groups" {
  type        = string
  default     = ""
  description = "Ignore these Google Workspace groups"
}

variable "ignore_users" {
  type        = string
  default     = ""
  description = "Ignore these Google Workspace users"
}

variable "include_groups" {
  type        = string
  default     = ""
  description = "Include only these Google Workspace groups. (Only applicable for sync_method user_groups)"
}

variable "log_format" {
  type        = string
  default     = "json"
  description = "Log format for Lambda function logging"

  validation {
    condition     = contains(["json", "text"], var.log_format)
    error_message = "Allowed values: `json`, `text`"
  }
}

variable "log_level" {
  type        = string
  default     = "warn"
  description = "Log level for Lambda function logging"

  validation {
    condition     = contains(["panic", "fatal", "error", "warn", "info", "debug", "trace"], var.log_level)
    error_message = "Allowed values: `panic`, `fatal`, `error`, `warn`, `info`, `debug`, `trace`"
  }
}

variable "schedule_expression" {
  type        = string
  default     = "rate(15 minutes)"
  description = "Schedule for trigger the execution of ssosync (see CloudWatch schedule expressions)"
}

variable "ssosync_url_prefix" {
  type        = string
  default     = "https://github.com/Benbentwo/ssosync/releases/download"
  description = "URL prefix for ssosync binary"
}

variable "ssosync_version" {
  type        = string
  default     = "v2.0.2"
  description = "Version of ssosync to use"
}

variable "sync_method" {
  type        = string
  default     = "groups"
  description = "Sync method to use"

  validation {
    condition     = contains(["groups", "users_groups"], var.sync_method)
    error_message = "Allowed values: `groups`, `users_groups`"
  }
}
