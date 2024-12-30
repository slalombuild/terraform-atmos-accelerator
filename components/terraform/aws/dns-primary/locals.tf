locals {
  certificate_enabled = module.this.enabled && var.request_acm_certificate
  domains_set         = toset(var.domain_names[*].domain_name)
  zone_alias_map      = { for zone in var.alias_record_config : "${zone.name}${zone.root_zone}.${zone.type}" => zone }
  zone_recs_map       = { for zone in var.record_config : "${zone.name}${zone.root_zone}.${zone.type}" => zone }
}
