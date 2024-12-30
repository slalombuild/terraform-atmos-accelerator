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

variable "acm_certificate_domain" {
  type        = string
  default     = null
  description = "Domain to get the ACM cert to use on the ALB."
}

variable "alb_configuration" {
  type        = map(any)
  default     = {}
  description = "Map of multiple ALB configurations."
}

variable "alb_ingress_cidr_blocks_http" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks allowed to access environment over HTTP"
}

variable "alb_ingress_cidr_blocks_https" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks allowed to access environment over HTTPS"
}

variable "container_insights_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to enable container insights"
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "The domain name to use to create the record for the ecs app"
}

variable "internal_enabled" {
  type        = bool
  default     = false
  description = "Whether to create an internal load balancer for services in this cluster"
}

variable "maintenance_page_path" {
  type        = string
  default     = "templates/503_example.html"
  description = "The path from this directory to the text/html page to use as the maintenance page. Must be within 1024 characters"
}

variable "route53_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to create a route53 record for the ALB"
}

variable "route53_record_name" {
  type        = string
  default     = "*"
  description = "The route53 record name"
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
}
