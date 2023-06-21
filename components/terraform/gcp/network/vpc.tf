provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/network/google//modules/vpc"
<<<<<<< HEAD
  version = "~> 7.0.0"
=======
  version = "~> 2.0.0"
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)

  project_id   = var.project_id
  network_name = module.this.id
  routing_mode = var.routing_mode
<<<<<<< HEAD
  description  = var.vpc_description
  mtu          = var.vpc_mtu
=======
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)

  shared_vpc_host                        = var.shared_vpc_host
  auto_create_subnetworks                = var.auto_create_subnetworks
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
<<<<<<< HEAD
=======

  context = module.this.context
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  count           = local.enabled && var.shared_vpc_host ? length(var.service_project_names) : 0
  host_project    = var.project_id
  service_project = var.service_project_names[count.index]

<<<<<<< HEAD
  depends_on = [module.vpc]
=======
  depends_on = [module.vpc[0]]
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
}

module "vpc_routes" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/network/google//modules/routes"
<<<<<<< HEAD
  version = "~> 7.0.0"
=======
  version = "~> 2.0.0"
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)

  project_id   = var.project_id
  network_name = module.vpc[0].network_name

  routes = var.routes
<<<<<<< HEAD
=======

  context = module.this.context
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
}





