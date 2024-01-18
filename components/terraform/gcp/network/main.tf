module "network" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0.0"

  project_id   = var.project_id
  network_name = var.name != null ? var.name : module.this.id
  routing_mode = var.routing_mode
  description  = var.vpc_description
  mtu          = var.vpc_mtu

  routes                  = var.routes
  auto_create_subnetworks = var.auto_create_subnetworks
  subnets                 = var.subnets
  secondary_ranges        = var.secondary_ranges
  firewall_rules          = var.firewall_rules
  shared_vpc_host         = var.shared_vpc_host

  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  count           = local.enabled && var.shared_vpc_host ? length(var.service_project_names) : 0
  host_project    = var.project_id
  service_project = var.service_project_names[count.index]

  depends_on = [module.network]
}





