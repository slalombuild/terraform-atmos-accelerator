locals {
  enabled = module.this.enabled

  private_enabled = local.enabled && var.dns_private_zone_enabled

}