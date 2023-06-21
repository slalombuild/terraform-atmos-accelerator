output "vpc" {
  description = "outputs of created VPC"
  value = [for i in module.vpc : {
    network           = i.network
    network_name      = i.network_name
    network_self_link = i.network_self_link
  }]
}

output "subnets" {
  value       = { for subnet in google_compute_subnetwork.subnets : "${subnet.name}" => subnet }
  description = "The new subnets."
}

output "router" {
  value       = module.cloud_router[0].router
  description = "The created router"
}

output "nat" {
  description = "Attributes of newly created NAT"
  value = [for i in module.cloud_nat[0] : {
    name                   = i.name
    nat_ip_allocate_option = i.nat_ip_allocate_option
    router_name            = i.router_name
  }]
}

output "firewall_rules" {
  description = "created firewall rules"
  value       = module.firewall_rules[0].firewall_rules
}