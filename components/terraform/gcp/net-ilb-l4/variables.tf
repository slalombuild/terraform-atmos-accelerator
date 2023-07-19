variable "project_id" {
  type        = string
  description = "The ID of the existing GCP project"
}

variable "region" {
  type        = string
  description = "Region used for GCP resources."
}

variable "firewall_project" {
  type        = string
  description = "Name of the project to create the firewall rule in. Useful for shared VPC. Default is var.project_id."
  default     = null
}

variable "network" {
  type        = string
  description = "Name of the network to create resources in."
  default     = "default"
}

variable "ip_address" {
  type        = string
  description = "IP address of the external load balancer, if empty one will be assigned."
  default     = null
}

variable "ip_protocol" {
  description = "The IP protocol for the frontend forwarding rule and firewall rule. TCP, UDP, ESP, AH, SCTP or ICMP."
  type        = string
  default     = "TCP"
}

variable "allowed_ips" {
  description = "The IP address ranges which can access the load balancer."
  type        = list(string)
  default     = []
}

variable "service_port" {
  description = "TCP port your service is listening on."
  type        = number
}

variable "target_tags" {
  description = "List of target tags to allow traffic using firewall rule."
  type        = list(string)
  default     = null
}

variable "target_service_accounts" {
  description = "List of target service accounts to allow traffic using firewall rule."
  type        = list(string)
  default     = null
}

variable "disable_health_check" {
  description = "Disables the health check on the target pool."
  type        = bool
  default     = false
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    check_interval_sec  = optional(number, 5),
    healthy_threshold   = optional(number, 2),
    timeout_sec         = optional(number, 5),
    unhealthy_threshold = optional(number, 2),
    port                = optional(number, 80),
    request_path        = optional(string, "/"),
    host                = optional(string, null)
  })
  default = {}
}

variable "session_affinity" {
  description = "How to distribute load. Options are NONE, CLIENT_IP and CLIENT_IP_PROTO"
  type        = string
  default     = "NONE"
}
