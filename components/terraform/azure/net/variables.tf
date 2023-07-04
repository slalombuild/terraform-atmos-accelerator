variable "location" {
  description = "Azure location to create resources in."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the azure resource group to contain the resources."
  type        = string
}

variable "create_resource_group" {
  type        = bool
  description = "If true, a new resource group will be created using resource_group_name. If false, resource_group_name must be an existing resource group."
  default     = true
  nullable    = false
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to resources created by this component."
  default     = {}
}

variable "network" {
  description = "Object with attributes: `address_space`, `subnets`. Set to null to disable."
  type = object({
    address_space = optional(string),
    subnets       = optional(object({}))
  })
  default = {}
}

variable "component_suffix" {
  type        = string
  description = "This component uses a naming module. The component_suffix will be suffixed to all resource names. Lowercase alphabet only."
  default     = "net"
  nullable    = false
}
