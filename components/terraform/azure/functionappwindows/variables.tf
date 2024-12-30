variable "location" {
  type        = string
  description = "Azure location for Function App and related resources."
}

variable "api_management_backends" {
  type = list(object({
    apim_name    = string,
    backend_name = optional(string, null)
    backend_path = string
  }))
  default = []
}

variable "app_service_environment_id" {
  type        = string
  default     = null
  description = "ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3."
}

variable "app_service_plan_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The name of the app service plan that function apps will be created within.
If no app service plan name is specified, the component will create a new one.
DESCRIPTION
}

variable "maximum_elastic_worker_count" {
  type        = number
  default     = null
  description = "Maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
}

variable "per_site_scaling_enabled" {
  type        = bool
  default     = false
  description = "Should per site scaling be enabled on the Service Plan."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The name of the resource group resources should be created within.
If no resource group name is specified, the component will create a new one.
DESCRIPTION
}

variable "role_assignment" {
  type        = map(list(string))
  default     = {}
  description = "The key value pair of role_defination_name and active directory name to assign user/role permissions"
}

variable "sku_name" {
  type        = string
  default     = "Y1"
  description = "The SKU for the Service Plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}

variable "worker_count" {
  type        = number
  default     = null
  description = "Number of Workers (instances) to be allocated."
}

variable "zone_balancing_enabled" {
  type        = bool
  default     = false
  description = "Should the Service Plan balance across Availability Zones in the region. Defaults to `false` because the default SKU `Y1` for the App Service Plan cannot use this feature."
}
