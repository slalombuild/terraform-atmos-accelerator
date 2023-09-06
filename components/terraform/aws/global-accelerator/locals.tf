locals {
  client_affinity     = var.client_affinity
  endpoint_lb_name    = var.endpoint_lb_name
  flow_logs_enabled   = var.flow_logs_enabled
  flow_logs_s3_prefix = var.flow_logs_s3_prefix
  ip_address_type     = var.ip_address_type
  protocol            = var.protocol
  http_port           = var.http_port
  https_port          = var.https_port
}
