resource "google_compute_network_peering" "peerings" {
  for_each     = local.enabled && var.peers != [] ? { for i, peer in var.peers : peer.name => peer.self_link } : {}
  name         = "${module.this.id}-${each.key}"
  network      = module.vpc[0].network_name
  peer_network = each.value

  depends_on = [
    google_service_networking_connection.private_vpc_connections
  ]
}
