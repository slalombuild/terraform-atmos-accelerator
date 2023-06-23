module "firewall_rules" {
  count        = local.enabled && var.firewall_rules != [] ? length(var.firewall_rules) : 0
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = var.firewall_rules

  depends_on = [google_compute_subnetwork.subnets]
}
