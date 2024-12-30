variable "account_map" {
  type        = map(any)
  description = "Account map of all the available accounts"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "zone_config" {
  type = list(object({
    subdomain = string
    zone_name = string
  }))
  description = "Zone config"
}

variable "aws_shield_protection_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable AWS Shield Advanced protection for Route53 Zones. If set to 'true', a subscription to AWS Shield Advanced must exist in this account."
}

variable "certificate_authority" {
  type        = string
  default     = null
  description = "Certificate authority for local private cert"
}

variable "certificate_authority_enabled" {
  type        = bool
  default     = false
  description = "Whether to use the certificate authority or not"
}

variable "dns_private_zone_enabled" {
  type        = bool
  default     = false
  description = "Whether to set the zone to public or private"
}

variable "dns_soa_config" {
  type        = string
  default     = "awsdns-hostmaster.amazon.com. 1 7200 900 1209600 60"
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
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
}

variable "vpc_region_abbreviation_type" {
  type        = string
  default     = "fixed"
  description = "Type of VPC abbreviation (either `fixed` or `short`) to use in names. See https://github.com/cloudposse/terraform-aws-utils for details."

  validation {
    condition     = contains(["fixed", "short"], var.vpc_region_abbreviation_type)
    error_message = "The vpc_region_abbreviation_type must be either \"fixed\" or \"short\"."
  }
}

variable "vpc_secondary_environment_names" {
  type        = list(string)
  default     = []
  description = "The names of the environments where secondary VPCs are deployed"
}
