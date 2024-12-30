variable "location" {
  type        = string
  description = "The location/region where the appInsights resource is created. Changing this forces a new resource to be created."
}

variable "application_type" {
  type        = string
  default     = "other"
  description = <<DESCRIPTION
  Specifies the type of Application Insights to create.
    Valid values are 'ios' for iOS, 'java' for Java web, 'MobileCenter' for App Center, 'Node.JS' for 'Node.js', 'other' for General, 'phone' for Windows Phone, 'store' for Windows Store and 'web' for ASP.NET.
    Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created.
  DESCRIPTION
}

variable "daily_data_cap_in_gb" {
  type        = number
  default     = 30
  description = "Specifies the Application Insights component daily data volume cap in GB."
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies if a notification email will be send when the daily data volume cap is met."
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

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. Defaults to false."
}

variable "force_customer_storage_for_profiler" {
  type        = bool
  default     = false
  description = "Should the Application Insights component force users to create their own storage account for profiling? Defaults to false."
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
}

variable "internet_query_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Application Insights component support querying over the Public Internet? Defaults to true."
}

variable "local_authentication_disabled" {
  type        = bool
  default     = false
  description = "(Optional) Disable Non-Azure AD based Auth. Defaults to false. When disabled, applications must use the `Monitoring Metrics Publisher` role in addition to the Instrumentation key to publish telemetry and API Keys cannot be used."
}

variable "log_analytics_workspace" {
  type = object({
    name                                    = optional(string, null)
    allow_resource_only_permissions         = optional(bool, true)
    cmk_for_query_forced                    = optional(bool)
    data_collection_rule_id                 = optional(string)
    daily_quota_gb                          = optional(string)
    immediate_data_purge_on_30_days_enabled = optional(bool)
    internet_ingestion_enabled              = optional(bool, false)
    internet_query_enabled                  = optional(bool, false)
    local_authentication_disabled           = optional(bool, true)
    reservation_capacity_in_gb_per_day      = optional(number)
    retention_in_days                       = optional(number)
    sku                                     = optional(string, "PerGB2018")
    identity_type                           = optional(string, "SystemAssigned")
    identity_ids                            = optional(list(string), [])

  })
  default     = {}
  description = "Manages a Log Analytics (formally Operational Insights) Workspace."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "Name of the resource group to which resource to be created"
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}

variable "role_assignment" {
  type        = map(list(string))
  default     = {}
  description = "The Key and Value Pair of role_defination_name and principal id to allow the users to access AppInsights"
}

variable "sampling_percentage" {
  type        = number
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
}

variable "smart_detector_alert_rules" {
  type = object({
    enabled          = optional(bool, false),
    action_group_ids = optional(list(string), []),
    rule_enabled     = optional(bool, true)
  })
  default     = {}
  description = "Required values to enable and make use of smart detection alerts on AppInsights"
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}
