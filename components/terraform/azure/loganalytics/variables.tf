variable "location" {
  type        = string
  description = "The location/region where the log_analytics_workspace resource is created. Changing this forces a new resource to be created."
}

variable "log_analytics_workspace" {
  type = object({
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

variable "role_assignment" {
  type        = map(list(string))
  default     = {}
  description = "The Key and Value Pair of role_defination_name and principal id to allow the users to access Log Analytics workspace"
}
