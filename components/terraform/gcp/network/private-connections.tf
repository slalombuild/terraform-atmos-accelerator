resource "google_compute_global_address" "private_ip_blocks" {
  for_each      = local.enabled && length(var.private_connections) > 0 ? { for i, private_connection in var.private_connections : i => private_connection } : {}
  project       = var.project_id
  name          = "${module.this.id}-${each.value.name}"
  description   = each.value.description
  purpose       = each.value.purpose
  address_type  = each.value.address_type
  ip_version    = each.value.ip_version
  address       = each.value.prefix_start
  prefix_length = each.value.prefix_length
  network       = module.vpc[0].network_name
}

resource "google_service_networking_connection" "private_vpc_connections" {
  count                   = local.enabled && length(var.private_connections) > 0 ? 1 : 0
  network                 = module.vpc[0].network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [for block in google_compute_global_address.private_ip_blocks : block.name]
}
