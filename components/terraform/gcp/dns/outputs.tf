output "zone_name" {
  value = one(module.cloud_dns[*].name)
}

output "domain" {
  value = one(module.cloud_dns[*].domain)
}

output "name_servers" {
  value = one(module.cloud_dns[*].name_servers)
}

output "dns_type" {
  value = one(module.cloud_dns[*].type)
}
