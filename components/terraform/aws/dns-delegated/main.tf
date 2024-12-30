resource "aws_route53_zone" "default" {
  for_each = local.public_enabled ? local.zone_map : {}

  name    = format("%s.%s", each.key, each.value)
  comment = format("DNS zone for %s.%s", each.key, each.value)
  tags    = module.this.tags
}

resource "aws_route53_zone" "private" {
  for_each = local.private_enabled ? local.zone_map : {}

  name    = format("%s.%s", each.key, each.value)
  comment = format("DNS zone for %s.%s", each.key, each.value)
  tags    = module.this.tags

  # The reason why this isn't in the original route53 zone is because this shows up as an update
  # when the aws provider should replace it. Using a separate resource allows the user to toggle
  # between private and public without manual targeted destroys.
  # See: https://github.com/hashicorp/terraform-provider-aws/issues/7614
  dynamic "vpc" {
    for_each = local.private_enabled ? [true] : []

    content {
      vpc_id = local.vpc_id
    }
  }

  # Prevent the deletion of associated VPCs after
  # the initial creation. See documentation on
  # aws_route53_zone_association for details
  # See https://github.com/hashicorp/terraform-provider-aws/issues/14872#issuecomment-682008493
  lifecycle {
    ignore_changes = [vpc]
  }
}

module "utils" {
  source  = "cloudposse/utils/aws"
  version = "1.3.0"
}

resource "aws_route53_zone_association" "secondary" {
  for_each = local.private_enabled && length(var.vpc_secondary_environment_names) > 0 ? toset(var.vpc_secondary_environment_names) : toset([])

  vpc_id     = local.vpc_id
  zone_id    = join("", local.aws_route53_zone[*].zone_id)
  vpc_region = module.utils.region_az_alt_code_maps[format("from_%s", var.vpc_region_abbreviation_type)][each.value]
}

resource "aws_shield_protection" "shield_protection" {
  for_each = local.enabled && var.aws_shield_protection_enabled ? local.aws_route53_zone : {}

  name         = local.aws_route53_zone[each.key].name
  resource_arn = format("arn:%s:route53:::hostedzone/%s", local.aws_partition, local.aws_route53_zone[each.key].id)
  tags         = module.this.context
}

resource "aws_route53_record" "soa" {
  for_each = local.enabled ? local.aws_route53_zone : {}

  name            = local.aws_route53_zone[each.key].name
  type            = "SOA"
  zone_id         = local.aws_route53_zone[each.key].zone_id
  allow_overwrite = true
  records = [
    format("${local.aws_route53_zone[each.key].name_servers[0]}%s %s", local.public_enabled ? "." : "", var.dns_soa_config)
  ]
  ttl = "60"
}

resource "aws_route53_record" "root_ns" {
  provider = aws.primary
  for_each = local.enabled ? data.aws_route53_zone.root_zone : {}

  name            = each.key
  type            = "NS"
  zone_id         = data.aws_route53_zone.root_zone[each.key].zone_id
  allow_overwrite = true
  records         = local.aws_route53_zone[each.key].name_servers
  ttl             = "30"
}
