resource "google_compute_subnetwork" "subnets" {
  for_each                 = local.enabled ? { for i, subnet in var.subnets : i => subnet } : {}
  project                  = var.project_id
  network                  = module.vpc[0].network_name
  name                     = "${module.this.id}-${subnet_name}"
  description              = each.value.description
  ip_cidr_range            = each.value.cidr
  region                   = var.region
  private_ip_google_access = each.value.private_google_access

  dynamic "log_config" {
    for_each = each.value.flow_logs == null ? [] : [each.value.flow_logs]
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_cidrs == [] ? {} : { for i, index in each.value.secondary_cidrs : i => index }
    content {
      range_name    = "${module.this.id}-${secondary_ip_range.value.name}"
      ip_cidr_range = secondary_ip_range.value.cidr
    }
  }
}