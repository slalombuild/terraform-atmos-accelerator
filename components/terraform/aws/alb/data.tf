data "aws_route53_zone" "default" {
  count = local.dns_enabled ? 1 : 0

  name = var.domain_name
}

data "aws_acm_certificate" "default" {
  count = local.enabled ? 1 : 0

  domain      = local.acm_certificate_domain
  most_recent = true
  statuses    = ["ISSUED"]
}

# If you know the tags of your existing VPC you can searh for it this way
data "aws_vpc" "main" {
  tags = {
    Name = format("%s-%s-%s", var.namespace, var.environment, var.vpc_name)
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "*public*"
  }
}
