locals {
  acm_certificate_domain = var.acm_certificate_domain
  alb_security_group_id  = []
  dns_enabled            = true
  enabled                = true
  public_subnet_ids      = data.aws_subnet_ids.public.ids
  target_group_name      = join("-", ["default", var.name])
  vpc_id                 = data.aws_vpc.main.id
  zone_id                = one(data.aws_route53_zone.default[*].zone_id)
}
