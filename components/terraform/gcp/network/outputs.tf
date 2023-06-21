output "vpc" {
  description = "outputs of created VPC"
  value = [for i in module.vpc : {
    network           = i.network
    network_name      = i.network_name
    network_self_link = i.network_self_link
  }]
}

output "subnets" {
<<<<<<< HEAD
  value       = local.enabled && var.subnets != [] ? { for subnet in google_compute_subnetwork.subnets : "${subnet.name}" => subnet } : null
=======
  value       = { for subnet in google_compute_subnetwork.subnets : "${subnet.name}" => subnet }
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
  description = "The new subnets."
}

output "router" {
<<<<<<< HEAD
  value       = local.enabled && var.cloud_nat != null ? module.cloud_router[0].router : null
=======
  value       = module.cloud_router[0].router
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
  description = "The created router"
}

output "nat" {
  description = "Attributes of newly created NAT"
<<<<<<< HEAD
  value = local.enabled && var.cloud_nat != null ? [for i in module.cloud_nat : {
    name                   = i.name
    nat_ip_allocate_option = i.nat_ip_allocate_option
    router_name            = i.router_name
  }] : null
=======
  value = [for i in module.cloud_nat[0] : {
    name                   = i.name
    nat_ip_allocate_option = i.nat_ip_allocate_option
    router_name            = i.router_name
  }]
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
}

output "firewall_rules" {
  description = "created firewall rules"
<<<<<<< HEAD
  value = local.enabled && var.firewall_rules != [] ? [for i in module.firewall_rules : {
    firewall_rules = i.firewall_rules
  }] : null
}

output "private_connections" {
  value       = local.enabled && var.private_connections != [] ? google_service_networking_connection.private_vpc_connections : null
  description = "The new private VPC connections."
}
=======
  value       = module.firewall_rules[0].firewall_rules
}
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
