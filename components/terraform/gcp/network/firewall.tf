module "firewall_rules" {
  count        = local.enabled && length(var.firewall_rules) > 0 ? length(var.firewall_rules) : 0
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "~> 7.0.0"
  project_id   = var.project_id
  network_name = module.vpc[0].network_name

  rules = var.firewall_rules

  depends_on = [google_compute_subnetwork.subnets]
}
