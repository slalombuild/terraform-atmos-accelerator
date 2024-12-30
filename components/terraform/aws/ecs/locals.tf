locals {
  acm_certificate_domain = var.acm_certificate_domain
  dns_enabled            = local.enabled && var.route53_enabled
  enabled                = module.this.enabled
  maintenance_page_fixed_response = {
    content_type = "text/html"
    status_code  = "503"
    message_body = file("${path.module}/${var.maintenance_page_path}")
  }
  private_subnet_ids = data.aws_subnet_ids.private.ids
  public_subnet_ids  = data.aws_subnet_ids.public.ids
  vpc_id             = data.aws_vpc.main.id
}
