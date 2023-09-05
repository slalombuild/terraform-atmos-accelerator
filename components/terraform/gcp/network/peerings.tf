resource "google_compute_network_peering" "peerings" {
  for_each     = local.enabled && length(var.peers) > 0 ? { for i, peer in var.peers : peer.name => peer.self_link } : {}
  name         = "${module.this.id}-${each.key}"
  network      = module.network[0].network_name
  peer_network = each.value

  depends_on = [
    google_service_networking_connection.private_vpc_connections
  ]
}
