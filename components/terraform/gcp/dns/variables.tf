variable "project_id" {
  description = "Project id for the zone."
  type        = string
}

variable "dns" {
  description = "the values needed to create a hozed zone and record sets"
  type = object({
    type        = string, # Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering', 'reverse_lookup' and 'service_directory'.
    domain_name = string, # Zone domain, must end with a period.
    description = optional(string, null),
    record_sets = optional(list(object({
      name    = string,
      type    = string, # value must be in upper case
      ttl     = optional(number, 300),
      records = list(string)
    })), []),
    dnssec_config                      = optional(any, {}),
    enable_logging                     = optional(bool, false),
    target_network                     = optional(string, null), # Peering network.
    target_name_server_addresses       = optional(list(map(any)), []),
    service_namespace_url              = optional(string, null)
    private_visibility_config_networks = optional(list(string), []),
    default_key_specs_key              = optional(any, {}),
    default_key_specs_zone             = optional(any, {}),
    force_destroy                      = optional(bool, false)
  })
  default = null
}