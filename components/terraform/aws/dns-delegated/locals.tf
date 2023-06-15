locals {
  enabled               = module.this.enabled
  zone_map              = zipmap(var.zone_config[*].subdomain, var.zone_config[*].zone_name)
  private_enabled       = local.enabled && var.dns_private_zone_enabled
  public_enabled        = local.enabled && !local.private_enabled
  private_ca_enabled    = local.private_enabled && var.certificate_authority_enabled
  aws_route53_zone      = local.private_enabled ? aws_route53_zone.private : aws_route53_zone.default
  vpc_environment_names = toset(concat([var.vpc_primary_environment_name], var.vpc_secondary_environment_names))
  aws_partition         = join("", data.aws_partition.current[*].partition)
  vpc_id                = data.aws_vpc.main.id
}
