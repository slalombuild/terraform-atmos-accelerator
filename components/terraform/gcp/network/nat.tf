module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
<<<<<<< HEAD
  version = "~> 5.0.1"
=======
  version = "~> 5.0"
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
  count   = local.enabled && var.cloud_nat != null ? 1 : 0
  name    = module.this.id
  project = var.project_id
  region  = var.region
<<<<<<< HEAD
  network = module.vpc[0].network_name
=======
  network = module.vpc.network_name

  context = module.this.context
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)

  depends_on = [google_compute_subnetwork.subnets]
}

module "cloud_nat" {
  count      = local.enabled && var.cloud_nat != null ? 1 : 0
  source     = "terraform-google-modules/cloud-nat/google"
<<<<<<< HEAD
  version    = "~> 4.0.0"
  project_id = var.project_id
  region     = var.region

  router = module.cloud_router[0].router.name

  name                               = module.this.id
  nat_ips                            = var.cloud_nat.nat_ips
=======
  version    = "~> 1.2"
  project_id = var.project_id
  region     = var.region

  router = module.cloud_router[0].router

  name                               = module.this.id
  nat_ips                            = var.cloud_nat.nat_ips
  nat_ip_allocate_option             = var.cloud_nat.nat_ip_allocate_option
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
  subnetworks                        = var.cloud_nat.subnetworks
  source_subnetwork_ip_ranges_to_nat = var.cloud_nat.source_subnetwork_ip_ranges_to_nat

  enable_dynamic_port_allocation      = var.cloud_nat.enable_dynamic_port_allocation
  enable_endpoint_independent_mapping = var.cloud_nat.enable_endpoint_independent_mapping
  icmp_idle_timeout_sec               = var.cloud_nat.icmp_idle_timeout_sec
  log_config_enable                   = var.cloud_nat.log_config_enable
  log_config_filter                   = var.cloud_nat.log_config_filter
  min_ports_per_vm                    = var.cloud_nat.min_ports_per_vm
  udp_idle_timeout_sec                = var.cloud_nat.udp_idle_timeout_sec
  tcp_established_idle_timeout_sec    = var.cloud_nat.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec     = var.cloud_nat.tcp_transitory_idle_timeout_sec
  tcp_time_wait_timeout_sec           = var.cloud_nat.tcp_time_wait_timeout_sec

<<<<<<< HEAD
  depends_on = [module.cloud_router]
}
=======
  depends_on = [google_compute_subnetwork.subnets]

  context = module.this.context
}
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
