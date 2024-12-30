variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "domain_name" {
  type        = string
  description = "Root domain name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "dns_private_zone_enabled" {
  type        = bool
  default     = false
  description = "Whether to set the zone to public or private"
}

variable "process_domain_validation_options" {
  type        = bool
  default     = false
  description = "Flag to enable/disable processing of the record to add to the DNS zone to complete certificate validation"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of domains that should be SANs in the issued certificate"
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "Method to use for validation, DNS or EMAIL"
}

variable "zone_name" {
  type        = string
  default     = ""
  description = <<-EOT
    Name of the zone in which to place the DNS validation records to validate the certificate.
    Typically a domain name. Default of `""` actually defaults to `domain_name`.
    EOT
}
