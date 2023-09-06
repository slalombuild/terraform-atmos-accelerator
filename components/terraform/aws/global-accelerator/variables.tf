variable "region" {
  type        = string
  description = "AWS region"
}

variable "ip_address_type" {
  description = "The address type to use for the Global Accelerator. At this moment, [only IPV4 is supported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_accelerator#ip_address_type)."
  type        = string
  default     = "IPV4"
  validation {
    condition     = var.ip_address_type == "IPV4"
    error_message = "Only IPV4 is supported."
  }
}

variable "endpoint_lb_name" {
  type        = string
  description = "Name of the ALB to use for the endpoint"
}

variable "flow_logs_enabled" {
  type        = bool
  description = "Control the creation of flow logs"
}

variable "flow_logs_s3_prefix" {
  type        = string
  description = "Flow logs s3 prefix for the global accelerator"
}

variable "client_affinity" {
  type        = string
  description = "Client affinity setting"
}

variable "protocol" {
  type        = string
  description = "Protocol to use"
}

variable "http_port" {
  type        = number
  description = "Define HTTP port"
}

variable "https_port" {
  type        = number
  description = "Define HTTPS port"
}

variable "account_number" {
  type        = string
  default     = null
  description = "The account number for the assume role"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}
