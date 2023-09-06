variable "region" {
  type        = string
  description = "The GCP region where the provider will operate."
}
# vars for vpc modules 
variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "auto_create_subnetworks" {
  type    = bool
  default = true
}

# vars for subnets
variable "subnets" {

  type = list(object({
    name                = string
    ip_cidr_range       = string
    region              = optional(string)
    description         = optional(string)
    secondary_ip_ranges = optional(list(object({ range_name = string, ip_cidr_range = string })))

  }))
  default = []
}

