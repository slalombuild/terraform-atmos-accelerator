data "aws_route53_zone" "default" {
  count        = local.enabled ? 1 : 0
  name         = var.zone_name
  private_zone = local.private_enabled
}