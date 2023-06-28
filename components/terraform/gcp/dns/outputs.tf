output "zone_name" {
  value = local.enabled ? module.cloud_dns[0].name : null
}

output "domain" {
  value = local.enabled ? module.cloud_dns[0].domain : null
}

output "name_servers" {
  value = local.enabled ? module.cloud_dns[0].name_servers : null
}

output "dns_type" {
  value = local.enabled ? module.cloud_dns[0].type : null
}