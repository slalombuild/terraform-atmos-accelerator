resource "azurerm_resource_group" "rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(module.this.tags,
    {
      "Component" : "dns",
      "ExpenseClass" : "network"
    }
  )
}

resource "azurerm_dns_zone" "public_dns" {
  for_each = { for domain in var.dns_zones : domain.domain_name => domain if !domain.private }

  name                = each.value.domain_name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  dynamic "soa_record" {
    for_each = each.value.soa_record != null ? [each.value.soa_record] : []

    content {
      email         = soa_record.value.email
      expire_time   = lookup(soa_record.value, "expire_time", 2419200)
      host_name     = lookup(soa_record.value, "host_name", null)
      minimum_ttl   = lookup(soa_record.value, "minimum_ttl", 300)
      refresh_time  = lookup(soa_record.value, "refresh_time", 3600)
      retry_time    = lookup(soa_record.value, "retry_time", 300)
      serial_number = lookup(soa_record.value, "serial_number", 1)
      ttl           = lookup(soa_record.value, "ttl", 3600)
    }
  }
}

resource "azurerm_private_dns_zone" "private_dns" {
  for_each = { for domain in var.dns_zones : domain.domain_name => domain if domain.private }

  name                = each.value.domain_name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  dynamic "soa_record" {
    for_each = each.value.soa_record != null ? [each.value.soa_record] : []

    content {
      email         = soa_record.value.email
      expire_time   = lookup(soa_record.value, "expire_time", 2419200)
      host_name     = lookup(soa_record.value, "host_name", null)
      minimum_ttl   = lookup(soa_record.value, "minimum_ttl", 300)
      refresh_time  = lookup(soa_record.value, "refresh_time", 3600)
      retry_time    = lookup(soa_record.value, "retry_time", 300)
      serial_number = lookup(soa_record.value, "serial_number", 1)
      ttl           = lookup(soa_record.value, "ttl", 3600)
    }
  }
}

resource "azurerm_dns_a_record" "a" {
  for_each = { for recordset in local.recordset_a : "${recordset.zone},${recordset.type},${recordset.name},${jsonencode(recordset.records)},${recordset.ttl}" => recordset }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  records             = each.value.records
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_a_record" "a_alias" {
  for_each = { for recordset in local.recordset_a_alias : "${recordset.zone},${recordset.type},${recordset.name},${recordset.record},${recordset.ttl}" => recordset }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })
  target_resource_id = each.value.record

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_aaaa_record" "aaaa" {
  for_each = { for recordset in local.recordset_aaaa : "${recordset.zone},${recordset.type},${recordset.name},${jsonencode(recordset.records)},${recordset.ttl}" => recordset }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  records             = each.value.records
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  depends_on = [
    azurerm_dns_zone.public_dns,
    azurerm_resource_group.rg
  ]
}

resource "azurerm_dns_cname_record" "cname" {
  for_each = { for recordset in local.recordset_cname : "${recordset.zone},${recordset.type},${recordset.name},${recordset.record},${recordset.ttl}" => recordset }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  record              = each.value.record
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_ns_record" "ns" {
  for_each = { for recordset in local.recordset_ns : "${recordset.zone},${recordset.type},${recordset.name},${jsonencode(recordset.records)},${recordset.ttl}" => recordset }

  name                = each.value.name
  records             = each.value.records
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_txt_record" "txt" {
  for_each = { for recordset in local.recordset_txt : "${recordset.zone},${recordset.type},${recordset.name},${jsonencode(recordset.records)},${recordset.ttl}" => recordset }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_ptr_record" "ptr" {
  for_each = { for recordset in local.recordset_ptr : "${recordset.zone},${recordset.type},${recordset.name},jsonencode(${recordset.records}),${recordset.ttl}" => recordset }

  name                = each.value.name
  records             = each.value.records
  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  depends_on = [azurerm_dns_zone.public_dns]
}

resource "azurerm_dns_mx_record" "recordset_mx" {
  for_each = { for recordset in local.recordset_mx : "${recordset.zone},${recordset.type},${recordset.name},${recordset.ttl}" => recordset }

  resource_group_name = data.azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone
  name                = each.value.name
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.dns_rg.name
  })

  dynamic "record" {
    for_each = each.value.mx_records

    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }

  depends_on = [azurerm_dns_zone.public_dns]
}
