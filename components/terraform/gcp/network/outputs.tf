output "network" {
  description = "outputs of created Network"
  value = local.enabled ? [for i in module.network : {
    network                  = i.network
    network_id               = i.network_id
    network_name             = i.network_name
    network_self_link        = i.network_self_link
    project_id               = i.project_id
    route_names              = i.route_names
    subnets                  = i.subnets
    subnets_flow_logs        = i.subnets_flow_logs
    subnets_ids              = i.subnets_ids
    subnets_names            = i.subnets_names
    subnets_private_access   = i.subnets_private_access
    subnets_secondary_ranges = i.subnets_secondary_ranges
    subnets_self_links       = i.subnets_self_links
  }] : null
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

output "private_connections" {
  value       = local.enabled && length(var.private_connections) > 0 ? google_service_networking_connection.private_vpc_connections : null
  description = "The new private VPC connections."
}
