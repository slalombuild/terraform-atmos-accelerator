provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 7.0.0"

  project_id   = var.project_id
  network_name = module.this.id
  routing_mode = var.routing_mode

  shared_vpc_host                        = var.shared_vpc_host
  auto_create_subnetworks                = var.auto_create_subnetworks
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes

  context = module.this.context
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  count           = local.enabled && var.shared_vpc_host ? length(var.service_project_names) : 0
  host_project    = var.project_id
  service_project = var.service_project_names[count.index]

  depends_on = [module.vpc[0]]
}

module "vpc_routes" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/network/google//modules/routes"
  version = "~> 7.0.0"

  project_id   = var.project_id
  network_name = module.vpc[0].network_name

  routes = var.routes

  context = module.this.context
}





