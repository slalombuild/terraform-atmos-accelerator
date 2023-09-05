output "external_ip" {
  description = "The external ip address of the forwarding rule"
  value       = one(module.network_lb[*].external_ip)
}

output "target_pool" {
  description = "The self_link to the target pool resource created."
  value       = one(module.network_lb[*].target_pool)
}
