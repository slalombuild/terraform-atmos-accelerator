variable "function_app_version" {
  description = "Version of the function app runtime to use."
  type        = number
  default     = 4
}

variable "function_app_application_settings" {
  description = "Function App application settings."
  type        = map(string)
  default     = {}
}

variable "function_app_settings" {
  description = "Function App application settings for data lookup to get ID's."
  type        = map(string)
  default = {
    "appinsights_name"       = null
    "cosmosdb_account_name"  = null
    "cosmosdb_database_name" = null
  }
}

variable "function_app_application_settings_drift_ignore" {
  description = "Ignore drift from settings manually set."
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
}

variable "ip_restriction_default_action" {
  description = "The Default action for traffic that does not match any ip_restriction rule. possible values include Allow and Deny. Defaults to Allow."
  type        = string
  default     = "Allow"
}

variable "authorized_ips" {
  description = "IPs restriction for Function in CIDR format. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_subnets" {
  description = "Subnets restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction"
  type = list(object({
    subnet_name = string,
    vnet_name   = string
  }))
  default = []
}

variable "ip_restriction_headers" {
  description = "IPs restriction headers for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#headers"
  type        = map(list(string))
  default     = null
}

variable "authorized_service_tags" {
  description = "Service Tags restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "function_app_vnet_integration" {
  description = "The subnet to associate with the Function App (Virtual Network integration)."
  type = object({
    subnet_name = string,
    vnet_name   = string,
  })
  default = null
}

variable "site_config" {
  description = "Site config for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block."
  type        = any
  default     = {}
}

variable "sticky_settings" {
  description = "Lists of connection strings and app settings to prevent from swapping between slots."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "https_only" {
  description = "Whether HTTPS traffic only is enabled."
  type        = bool
  default     = true
}

variable "builtin_logging_enabled" {
  description = "Whether built-in logging is enabled."
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Whether the Function App uses client certificates."
  type        = bool
  default     = null
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement for incoming requests. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`."
  type        = string
  default     = null
}

variable "application_zip_package_path" {
  description = "Local or remote path of a zip package to deploy on the Function App."
  type        = string
  default     = null
}

variable "staging_slot_enabled" {
  description = "Create a staging slot alongside the Function App for blue/green deployment purposes."
  type        = bool
  default     = false
}

variable "staging_slot_custom_application_settings" {
  description = "Override staging slot with custom application settings."
  type        = map(string)
  default     = null
}

variable "auth_settings_v2" {
  description = "Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2"
  type        = any
  default     = {}
}

# SCM parameters

variable "scm_authorized_ips" {
  description = "SCM IPs restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_subnet_ids" {
  description = "SCM subnets restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_ip_restriction_headers" {
  description = "IPs restriction headers for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = map(list(string))
  default     = null
}

variable "scm_authorized_service_tags" {
  description = "SCM Service Tags restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "storage_uses_managed_identity" {
  description = "Whether the Function App use Managed Identity to access the Storage Account. **Caution** This disable the storage keys on the Storage Account if created within the module."
  type        = bool
  default     = false
}

variable "cosmos_role_definition" {
  description = "The Built in or Custom role definition name for cosmos"
  type        = list(string)
  default     = []
}
