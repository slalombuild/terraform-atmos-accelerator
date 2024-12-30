variable "region" {
  type        = string
  description = "AWS Region"
}

variable "expiration_days" {
  type        = number
  default     = 90
  description = "Number of days after which to expunge the objects"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "glacier_transition_days" {
  type        = number
  default     = 60
  description = "Number of days after which to move the data to the glacier storage tier"
}

variable "lifecycle_prefix" {
  type        = string
  default     = ""
  description = "Prefix filter. Used to manage object lifecycle events"
}

variable "lifecycle_rule_enabled" {
  type        = bool
  default     = true
  description = "Enable lifecycle events on this bucket"
}

variable "lifecycle_tags" {
  type        = map(string)
  default     = {}
  description = "Tags filter. Used to manage object lifecycle events"
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
