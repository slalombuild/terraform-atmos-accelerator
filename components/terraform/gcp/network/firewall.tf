module "firewall_rules" {
  count        = local.enabled && var.firewall_rules != [] ? length(var.firewall_rules) : 0
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
<<<<<<< HEAD
  version      = "~> 7.0.0"
  project_id   = var.project_id
  network_name = module.vpc[0].network_name
=======
  project_id   = var.project_id
  network_name = module.vpc.network_name
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)

  rules = var.firewall_rules

  depends_on = [google_compute_subnetwork.subnets]
<<<<<<< HEAD
}
=======

  context = module.this.context
}
>>>>>>> 31b4528 (fixing the conflicts in stacks file of gcp)
