variable "region" {
  type        = string
  description = "AWS Region"
}

variable "domain_names" {
  type = list(object({
    domain_name     = string
    register_domain = optional(bool, "false")
    admin_contact = optional(list(object({
      address_line_1    = optional(string, null)
      address_line_2    = optional(string, null)
      city              = optional(string, null)
      contact_type      = optional(string, null) ## PERSON COMPANY ASSOCIATION PUBLIC_BODY RESELLER
      country_code      = optional(string, null)
      email             = optional(string, null)
      extra_params      = optional(map(string))
      fax               = optional(string, null)
      first_name        = optional(string, null)
      last_name         = optional(string, null)
      organization_name = optional(string, null)
      phone_number      = optional(string, null)
      state             = optional(string, null)
      zip_code          = optional(string, null)
      }
    )))
    registrant_contact = optional(list(object({
      address_line_1    = optional(string, null)
      address_line_2    = optional(string, null)
      city              = optional(string, null)
      contact_type      = optional(string, null) ## PERSON COMPANY ASSOCIATION PUBLIC_BODY RESELLER
      country_code      = optional(string, null)
      email             = optional(string, null)
      extra_params      = optional(map(string))
      fax               = optional(string, null)
      first_name        = optional(string, null)
      last_name         = optional(string, null)
      organization_name = optional(string, null)
      phone_number      = optional(string, null)
      state             = optional(string, null)
      zip_code          = optional(string, null)
      }
    )))
    tech_contact = optional(list(object({
      address_line_1    = optional(string, null)
      address_line_2    = optional(string, null)
      city              = optional(string, null)
      contact_type      = optional(string, null) ## PERSON COMPANY ASSOCIATION PUBLIC_BODY RESELLER
      country_code      = optional(string, null)
      email             = optional(string, null)
      extra_params      = optional(map(string))
      fax               = optional(string, null)
      first_name        = optional(string, null)
      last_name         = optional(string, null)
      organization_name = optional(string, null)
      phone_number      = optional(string, null)
      state             = optional(string, null)
      zip_code          = optional(string, null)
      }
    )))
  }))
  description = <<-EOT
    Root domain name list, e.g. and the option to attempt registering the domain.
    Admin, tech and registrant contact only work if register_domain is true, but they are still optional
    e.g.:
    [
      {
        domain_name = "example.net"
        register_domain = false
        admin_contact:
          - first_name: "John"
            last_name: "Wick"
      }
    ]
   EOT
}

variable "record_config" {
  description = "DNS Record config"
  type = list(object({
    root_zone = string
    name      = string
    type      = string
    ttl       = string
    records   = list(string)
  }))
  default = []
}

# Elastic Load Balancing Hosted Zone IDs can be found here: https://docs.aws.amazon.com/general/latest/gr/elb.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record#alias-record
variable "alias_record_config" {
  description = "DNS Alias Record config"
  type = list(object({
    root_zone              = string
    name                   = string
    type                   = string
    zone_id                = string
    record                 = string
    evaluate_target_health = bool
  }))
  default = []
}

variable "dns_soa_config" {
  type        = string
  description = <<-EOT
    Root domain name DNS SOA record:
    - awsdns-hostmaster.amazon.com. ; AWS default value for administrator email address
    - 1 ; serial number, not used by AWS
    - 7200 ; refresh time in seconds for secondary DNS servers to refreh SOA record
    - 900 ; retry time in seconds for secondary DNS servers to retry failed SOA record update
    - 1209600 ; expire time in seconds (1209600 is 2 weeks) for secondary DNS servers to remove SOA record if they cannot refresh it
    - 60 ; nxdomain TTL, or time in seconds for secondary DNS servers to cache negative responses
    See [SOA Record Documentation](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/SOA-NSrecords.html) for more information.
   EOT
  default     = "awsdns-hostmaster.amazon.com. 1 7200 900 1209600 60"
}

variable "soa_record_ttl" {
  type        = number
  description = "TTL of the SOA record for the domain"
  default     = 60
}

variable "account_map" {
  type        = map(any)
  description = "Account map of all the available accounts"
  default     = {}
}
