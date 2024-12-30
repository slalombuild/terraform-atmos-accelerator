variable "application_insights_enabled" {
  description = "Whether Application Insights should be deployed."
  type        = bool
  default     = true
}

variable "application_insights_id" {
  description = "ID of the existing Application Insights to use instead of deploying a new one."
  type        = string
  default     = null
}

variable "application_insights_type" {
  description = "Application Insights type if need to be generated. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type"
  type        = string
  default     = "web"
}

variable "application_insights_daily_data_cap" {
  description = "Daily data volume cap (in GB) for Application Insights."
  type        = number
  default     = null
}

variable "application_insights_daily_data_cap_notifications_disabled" {
  description = "Whether disable email notifications when data volume cap is met."
  type        = bool
  default     = null
}

variable "application_insights_retention" {
  description = "Retention period (in days) for logs."
  type        = number
  default     = 90
}

variable "application_insights_internet_ingestion_enabled" {
  description = "Whether ingestion support from Application Insights component over the Public Internet is enabled."
  type        = bool
  default     = true
}

variable "application_insights_internet_query_enabled" {
  description = "Whether querying support from Application Insights component over the Public Internet is enabled."
  type        = bool
  default     = true
}

variable "application_insights_ip_masking_disabled" {
  description = "Whether IP masking in logs is disabled."
  type        = bool
  default     = false
}

variable "application_insights_local_authentication_disabled" {
  description = "Whether Non-Azure AD based authentication is disabled."
  type        = bool
  default     = false
}

variable "application_insights_force_customer_storage_for_profiler" {
  description = "Whether to enforce users to create their own Storage Account for profiling in Application Insights."
  type        = bool
  default     = false
}

variable "application_insights_log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace to be used with Application Insights."
  type        = string
  default     = null
}

variable "application_insights_sampling_percentage" {
  description = "Percentage of data produced by the monitored application sampled for Application Insights telemetry."
  type        = number
  default     = null
}

variable "diagnostic_setting" {
  type = object({
    enabled                        = optional(bool, false),
    storage_account_name           = optional(string, null)
    eventhub_name                  = optional(string, null),
    eventhub_authorization_rule_id = optional(string, null),
    log_analytics_workspace_name   = optional(string, null),
    log_analytics_destination_type = optional(string, "AzureDiagnostics"),
    metrics = optional(object({
      enabled  = optional(bool, true),
      category = optional(string, "AllMetrics")
    }), {}),
    logs = optional(object({
      category       = optional(string, null),
      category_group = optional(string, "AllLogs")
    }), {}),
  })
  default     = {}
  description = <<DESCRIPTION
  The values reuired for creating Diagnostic Setting to sends/store resource logs
  Defaults to `{}`.
  - `log_analytics_destination_type` - Deafults to `AzureDiagnostics`. The possible values are `Dedicated`, `AzureDiagnostics`.  When set to `Dedicated`, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy `AzureDiagnostics` table.
  DESCRIPTION
}
