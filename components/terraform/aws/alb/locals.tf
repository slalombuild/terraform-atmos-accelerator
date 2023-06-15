locals {
  dns_enabled            = true
  enabled                = true
  acm_certificate_domain = var.acm_certificate_domain
  zone_id                = one(data.aws_route53_zone.default[*].zone_id)
  vpc_id                 = data.aws_vpc.main.id
  public_subnet_ids      = data.aws_subnet_ids.public.ids
  target_group_name      = join("-", ["default", var.name])
  alb_security_group_id  = []
}
