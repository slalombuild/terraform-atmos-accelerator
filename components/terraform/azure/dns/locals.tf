locals {
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
  recordset_a = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone    = zone.domain_name
        name    = recordset.name
        type    = recordset.type
        ttl     = recordset.ttl
        records = recordset.records
      }
      if recordset.type == "a"
    ]
  ])
  recordset_a_alias = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone   = zone.domain_name
        name   = recordset.name
        type   = recordset.type
        ttl    = recordset.ttl
        record = recordset.record
      }
      if recordset.type == "a_alias"
    ]
  ])
  recordset_aaaa = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone    = zone.domain_name
        name    = recordset.name
        type    = recordset.type
        ttl     = recordset.ttl
        records = recordset.records
      }
      if recordset.type == "aaaa"
    ]
  ])
  recordset_cname = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone   = zone.domain_name
        name   = recordset.name
        type   = recordset.type
        ttl    = recordset.ttl
        record = recordset.record
      }
      if recordset.type == "cname"
    ]
  ])
  recordset_mx = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone       = zone.domain_name
        name       = recordset.name
        type       = recordset.type
        ttl        = recordset.ttl
        mx_records = recordset.mx_records
      }
      if recordset.type == "mx"
    ]
  ])
  recordset_ns = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone    = zone.domain_name
        name    = recordset.name
        type    = recordset.type
        ttl     = recordset.ttl
        records = recordset.records
      }
      if recordset.type == "ns"
    ]
  ])
  recordset_ptr = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone    = zone.domain_name
        name    = recordset.name
        type    = recordset.type
        ttl     = recordset.ttl
        records = recordset.records
      }
      if recordset.type == "ptr"
    ]
  ])
  recordset_txt = flatten([
    for zone in var.dns_zones : [
      for recordset in coalesce(zone.recordset, []) : {
        zone    = zone.domain_name
        name    = recordset.name
        type    = recordset.type
        ttl     = recordset.ttl
        records = recordset.records
      }
      if recordset.type == "txt"
  ]])
}
