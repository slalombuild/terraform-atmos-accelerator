resource "aws_route53_zone" "root" {
  for_each = local.domains_set

  name    = each.value
  comment = "DNS zone for the ${each.value} root domain"
  tags    = module.this.tags
}

resource "aws_route53domains_registered_domain" "registered_domain" {
  for_each = { for domain in var.domain_names : domain.domain_name => domain if domain.register_domain }

  domain_name = each.value.domain_name
  tags        = module.this.tags

  dynamic "admin_contact" {
    for_each = each.value.admin_contact != null ? each.value.admin_contact : []

    content {
      address_line_1    = admin_contact.value.address_line_1
      address_line_2    = admin_contact.value.address_line_2
      city              = admin_contact.value.city
      contact_type      = admin_contact.value.contact_type
      country_code      = admin_contact.value.country_code
      email             = admin_contact.value.email
      extra_params      = admin_contact.value.extra_params
      fax               = admin_contact.value.fax
      first_name        = admin_contact.value.first_name
      last_name         = admin_contact.value.last_name
      organization_name = admin_contact.value.organization_name
      phone_number      = admin_contact.value.phone_number
      state             = admin_contact.value.state
      zip_code          = admin_contact.value.zip_code
    }
  }
  dynamic "name_server" {
    for_each = toset(aws_route53_zone.root[each.value.domain_name].name_servers)

    content {
      name = name_server.value
    }
  }
  dynamic "registrant_contact" {
    for_each = each.value.registrant_contact != null ? each.value.registrant_contact : []

    content {
      address_line_1    = registrant_contact.value.address_line_1
      address_line_2    = registrant_contact.value.address_line_2
      city              = registrant_contact.value.city
      contact_type      = registrant_contact.value.contact_type
      country_code      = registrant_contact.value.country_code
      email             = registrant_contact.value.email
      extra_params      = registrant_contact.value.extra_params
      fax               = registrant_contact.value.fax
      first_name        = registrant_contact.value.first_name
      last_name         = registrant_contact.value.last_name
      organization_name = registrant_contact.value.organization_name
      phone_number      = registrant_contact.value.phone_number
      state             = registrant_contact.value.state
      zip_code          = registrant_contact.value.zip_code
    }
  }
  dynamic "tech_contact" {
    for_each = each.value.tech_contact != null ? each.value.tech_contact : []

    content {
      address_line_1    = tech_contact.value.address_line_1
      address_line_2    = tech_contact.value.address_line_2
      city              = tech_contact.value.city
      contact_type      = tech_contact.value.contact_type
      country_code      = tech_contact.value.country_code
      email             = tech_contact.value.email
      extra_params      = tech_contact.value.extra_params
      fax               = tech_contact.value.fax
      first_name        = tech_contact.value.first_name
      last_name         = tech_contact.value.last_name
      organization_name = tech_contact.value.organization_name
      phone_number      = tech_contact.value.phone_number
      state             = tech_contact.value.state
      zip_code          = tech_contact.value.zip_code
    }
  }
}

resource "aws_route53_record" "soa" {
  for_each = aws_route53_zone.root

  name            = aws_route53_zone.root[each.key].name
  type            = "SOA"
  zone_id         = aws_route53_zone.root[each.key].zone_id
  allow_overwrite = true
  records = [
    "${aws_route53_zone.root[each.key].name_servers[0]}. ${var.dns_soa_config}"
  ]
  ttl = var.soa_record_ttl
}

resource "aws_route53_record" "dnsrec" {
  for_each = local.zone_recs_map

  name    = format("%s%s", each.value.name, each.value.root_zone)
  type    = each.value.type
  zone_id = aws_route53_zone.root[each.value.root_zone].zone_id
  records = each.value.records
  ttl     = each.value.ttl
}

resource "aws_route53_record" "aliasrec" {
  for_each = local.zone_alias_map

  name    = format("%s%s", each.value.name, each.value.root_zone)
  type    = each.value.type
  zone_id = aws_route53_zone.root[each.value.root_zone].zone_id

  alias {
    evaluate_target_health = each.value.evaluate_target_health
    name                   = each.value.record
    zone_id                = each.value.zone_id
  }
}
