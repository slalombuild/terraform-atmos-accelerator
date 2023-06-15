locals {
  enabled = module.this.enabled

  dns_enabled = local.enabled && var.route53_enabled

  acm_certificate_domain = var.acm_certificate_domain
  maintenance_page_fixed_response = {
    content_type = "text/html"
    status_code  = "503"
    message_body = file("${path.module}/${var.maintenance_page_path}")
  }
  vpc_id             = data.aws_vpc.main.id
  private_subnet_ids = data.aws_subnet_ids.private.ids
  public_subnet_ids  = data.aws_subnet_ids.public.ids
}
