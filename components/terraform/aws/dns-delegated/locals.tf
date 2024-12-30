locals {
  aws_partition      = join("", data.aws_partition.current[*].partition)
  aws_route53_zone   = local.private_enabled ? aws_route53_zone.private : aws_route53_zone.default
  enabled            = module.this.enabled
  private_ca_enabled = local.private_enabled && var.certificate_authority_enabled
  private_enabled    = local.enabled && var.dns_private_zone_enabled
  public_enabled     = local.enabled && !local.private_enabled
  vpc_id             = data.aws_vpc.main.id
  zone_map           = zipmap(var.zone_config[*].subdomain, var.zone_config[*].zone_name)
}
