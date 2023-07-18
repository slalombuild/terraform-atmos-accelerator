output "http-lb" {
  description = "The otputs of created load balancer"
  sensitive   = true
  value = local.enabled ? [for i in module.lb-http : {
    backend_services      = i.backend_services
    external_ip           = i.external_ip
    external_ipv6_address = i.external_ipv6_address
    http_proxy            = i.http_proxy
    https_proxy           = i.https_proxy
    ipv6_enabled          = i.ipv6_enabled
    url_map               = i.url_map
  }] : null
}
