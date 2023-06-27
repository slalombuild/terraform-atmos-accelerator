output "zone_name" {
  value = module.cloud_dns[0].name
}

output "domain" {
  value = module.cloud_dns[0].domain
}

output "name_servers" {
  value = module.cloud_dns[0].name_servers
}

output "dns_type" {
  value = module.cloud_dns[0].type
}