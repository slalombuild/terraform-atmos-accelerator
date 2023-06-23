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
  value       = local.enabled && var.cloud_nat != null ? module.cloud_router[0].router : null
  description = "The created router"
}

output "nat" {
  description = "Attributes of newly created NAT"
  value = local.enabled && var.cloud_nat != null ? [for i in module.cloud_nat : {
    name                   = i.name
    nat_ip_allocate_option = i.nat_ip_allocate_option
    router_name            = i.router_name
  }] : null
}

output "firewall_rules" {
  description = "created firewall rules"
  value = local.enabled && var.firewall_rules != [] ? [for i in module.firewall_rules : {
    firewall_rules = i.firewall_rules
  }] : null
}
