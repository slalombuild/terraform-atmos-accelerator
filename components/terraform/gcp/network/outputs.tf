output "vpc" {
  description = "outputs of created VPC"
  value = local.enabled ? [for i in module.vpc : {
    network           = i.network
    network_name      = i.network_name
    network_self_link = i.network_self_link
  }] : null
}

output "subnets" {
  value       = local.enabled && length(var.subnets) > 0 ? { for subnet in google_compute_subnetwork.subnets : "${subnet.name}" => subnet } : null
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
  value = local.enabled && length(var.firewall_rules) > 0 ? [for i in module.firewall_rules : {
    firewall_rules = i.firewall_rules
  }] : null
}

output "private_connections" {
  value       = local.enabled && length(var.private_connections) > 0 ? google_service_networking_connection.private_vpc_connections : null
  description = "The new private VPC connections."
}
