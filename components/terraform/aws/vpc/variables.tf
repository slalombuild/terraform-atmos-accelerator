variable "availability_zones" {
  type        = list(string)
  description = <<-EOT
    List of Availability Zones (AZs) where subnets will be created. Ignored when `availability_zone_ids` is set.
    The order of zones in the list ***must be stable*** or else Terraform will continually make changes.
    If no AZs are specified, then `max_subnet_count` AZs will be selected in alphabetical order.
    If `max_subnet_count > 0` and `length(var.availability_zones) > max_subnet_count`, the list
    will be truncated. We recommend setting `availability_zones` and `max_subnet_count` explicitly as constant
    (not computed) values for predictability, consistency, and stability.
    EOT
}

variable "ipv4_primary_cidr_block" {
  type        = string
  description = <<-EOT
    The primary IPv4 CIDR block for the VPC.
    Either `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both.
    EOT
}

variable "nat_gateway_enabled" {
  type        = bool
  description = <<-EOT
    Set `true` to create NAT Gateways to perform IPv4 NAT and NAT64 as needed.
    Defaults to `true` unless `nat_instance_enabled` is `true`.
    EOT
}

variable "region" {
  type        = string
  description = "The AWS region where the provider will operate."
}

variable "account_map" {
  type        = map(any)
  default     = {}
  description = "Account map of all the available accounts"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = true
  description = "Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests"
}

variable "enable_vpc_endpoints" {
  type        = bool
  default     = true
  description = "To enable or disable the creation of the VPC endpoint. Used mostly for VPC changes and redeploy"
}

variable "expiration_days" {
  type        = number
  default     = 90
  description = "Number of days after which to expunge the objects"
}

variable "flow_log_enabled" {
  type        = bool
  default     = true
  description = "Enable/disable the Flow Log creation. Useful in multi-account environments where the bucket is in one account, but VPC Flow Logs are in different accounts"
}

variable "glacier_transition_days" {
  type        = number
  default     = 60
  description = "Number of days after which to move the data to the glacier storage tier"
}

variable "ipv4_cidrs" {
  type = list(object({
    private = list(string)
    public  = list(string)
  }))
  default     = []
  description = <<-EOT
    Lists of CIDRs to assign to subnets. Order of CIDRs in the lists must not change over time.
    Lists may contain more CIDRs than needed.
    EOT

  validation {
    condition     = length(var.ipv4_cidrs) < 2
    error_message = "Only 1 ipv4_cidrs object can be provided. Lists of CIDRs are passed via the `public` and `private` attributes of the single object."
  }
}

variable "lifecycle_rule_enabled" {
  type        = bool
  default     = true
  description = "Enable lifecycle events on this bucket"
}

variable "noncurrent_version_expiration_days" {
  type        = number
  default     = 90
  description = "Specifies when noncurrent object versions expire"
}

variable "noncurrent_version_transition_days" {
  type        = number
  default     = 30
  description = "Specifies when noncurrent object versions transitions"
}

variable "standard_transition_days" {
  type        = number
  default     = 30
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
}

variable "traffic_type" {
  type        = string
  default     = "ALL"
  description = "The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL`"
}

variable "transit_gateway_id" {
  type        = string
  default     = ""
  description = "Id of the transit gateway to route VPN traffic to"
}
