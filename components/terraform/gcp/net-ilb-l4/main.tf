module "network_lb" {
  count                   = local.enabled ? 1 : 0
  source                  = "terraform-google-modules/lb/google"
  version                 = "~>4.0.1"
  region                  = var.region
  project                 = var.project_id
  firewall_project        = var.firewall_project != null ? var.firewall_project : var.project_id
  name                    = module.this.id
  network                 = var.network
  ip_address              = var.ip_address
  ip_protocol             = var.ip_protocol
  service_port            = var.service_port
  target_tags             = var.target_tags
  target_service_accounts = var.target_service_accounts
  allowed_ips             = var.allowed_ips
  disable_health_check    = var.disable_health_check
  health_check            = var.health_check
  session_affinity        = var.session_affinity
  labels                  = module.this.tags
}
