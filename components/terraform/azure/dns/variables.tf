variable "dns_zones" {
  type = list(object({
    domain_name = string
    private     = optional(bool, false)
    recordset = optional(list(object({
      name    = string
      ttl     = optional(number, 3600)
      record  = optional(string, null)
      records = optional(list(string), null)
      mx_records = optional(list(object({
        exchange   = string
        preference = number
      })), null)
      type = string
    })), null)
    soa_record = optional(object({
      email         = string
      host_name     = optional(string, null)
      expire_time   = optional(number, 2419200)
      minimum_ttl   = optional(number, 300)
      refresh_time  = optional(number, 3600)
      retry_time    = optional(number, 300)
      serial_number = optional(number, 1)
      ttl           = optional(number, 3600)
    }), null)
  }))
  description = <<DESCRIPTION
The (previously registered) domains to create DNS zones for. Set private to
true for a private DNS zone.
DESCRIPTION

  validation {
    condition = alltrue([
      for zone in var.dns_zones : alltrue([
        for record in coalesce(zone.recordset, []) :
        record.type == lower(record.type) &&
        contains(["a", "a_alias", "aaaa", "ns", "txt", "ptr", "cname", "mx"], record.type)
      ])
    ])
    error_message = "Each recordset type must be lowercase and must be one of the following types: a, aaaa, ns, txt, ptr, cname, or mx."
  }
}

variable "location" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Azure region where the resource should be deployed.
If null, the location will be inferred from the resource group location.
DESCRIPTION
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
