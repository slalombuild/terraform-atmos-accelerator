variable "use_existing_storage_account" {
  description = "Whether existing Storage Account should be used instead of creating a new one."
  type        = bool
  default     = false
}

variable "storage_account_id" {
  description = "ID of the existing Storage Account to use."
  type        = string
  default     = null
}

variable "storage_account_kind" {
  description = "Storage Account Kind."
  type        = string
  default     = "StorageV2"
}

variable "storage_account_min_tls_version" {
  description = "Storage Account minimal TLS version."
  type        = string
  default     = "TLS1_2"
}

variable "storage_account_enable_advanced_threat_protection" {
  description = "Whether advanced threat protection is enabled. See documentation: https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal"
  type        = bool
  default     = false
}

variable "storage_account_https_traffic_only_enabled" {
  description = "Whether HTTPS traffic only is enabled for Storage Account."
  type        = bool
  default     = true
}

variable "storage_account_identity_type" {
  description = "Type of Managed Service Identity that should be configured on the Storage Account."
  type        = string
  default     = null
}

variable "storage_account_identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to the Storage Account."
  type        = list(string)
  default     = null
}

variable "storage_account_network_rules_enabled" {
  description = "Whether to enable Storage Account network default rules for functions."
  type        = bool
  default     = true
}

variable "storage_account_network_bypass" {
  description = "Whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`."
  type        = list(string)
  default     = ["Logging", "Metrics", "AzureServices"]
}

variable "storage_account_authorized_ips" {
  description = "IPs restrictions for Function Storage Account in CIDR format."
  type        = list(string)
  default     = []
}

variable "storage_account_replication_type" {
  type        = string
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS`"
  nullable    = false
  default     = "RAGZRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_account_replication_type)
    error_message = "Invalid value for replication type. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`."
  }
}
