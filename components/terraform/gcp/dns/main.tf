module "cloud_dns" {
  count       = local.enabled ? 1 : 0
  source      = "terraform-google-modules/cloud-dns/google"
  version     = "5.2.0"
  project_id  = var.project_id
  type        = var.dns.type
  name        = module.this.id
  domain      = var.dns.domain_name
  description = var.dns.description

  private_visibility_config_networks = var.dns.private_visibility_config_networks

  recordsets     = var.dns.record_sets
  dnssec_config  = var.dns.dnssec_config
  enable_logging = var.dns.enable_logging

  target_network               = var.dns.target_network
  target_name_server_addresses = var.dns.target_name_server_addresses
  service_namespace_url        = var.dns.service_namespace_url
  default_key_specs_key        = var.dns.default_key_specs_key
  default_key_specs_zone       = var.dns.default_key_specs_zone

  labels        = module.this.tags
  force_destroy = var.dns.force_destroy

}
