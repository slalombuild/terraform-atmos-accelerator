output "resource" {
  description = "The service bus namespace created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace.html#attributes-reference"
  sensitive   = true
  value       = try(module.service_bus[0].resource, null)
}

output "resource_authorization_rules" {
  description = "The service bus namespace authorization rules created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule#attributes-reference"
  sensitive   = true
  value       = try(module.service_bus[0].resource_authorization_rules, null)
}

output "resource_diagnostic_settings" {
  description = "The diagnostic settings created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting#attributes-reference"
  value       = try(module.service_bus[0].resource_diagnostic_settings, null)
}

output "resource_id" {
  description = "The resource ID of the service bus namespace created."
  value       = try(module.service_bus[0].resource_id, null)
}

output "resource_locks" {
  description = "The management locks created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock#attributes-reference"
  value       = try(module.service_bus[0].resource_locks, null)
}

output "resource_private_endpoints" {
  description = "A map of the private endpoints created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint#attributes-reference"
  value       = try(module.service_bus[0].resource_private_endpoints, null)
}

output "resource_private_endpoints_application_security_group_association" {
  description = "The private endpoint application security group associations created"
  value       = try(module.service_bus[0].resource_private_endpoints_application_security_group_association, null)
}

output "resource_queues" {
  description = "The service bus queues created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association#attributes-reference"
  value       = try(module.service_bus[0].resource_queues, null)
}

output "resource_queues_authorization_rules" {
  description = "The service bus queues authorization rules created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue_authorization_rule#attributes-reference"
  sensitive   = true
  value       = try(module.service_bus[0].resource_queues_authorization_rules, null)
}

output "resource_role_assignments" {
  description = "The role assignments created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment#attributes-reference"
  value       = try(module.service_bus[0].resource_role_assignments, null)
}

output "resource_topics" {
  description = "The service bus topics created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic.html#attributes-reference"
  value       = try(module.service_bus[0].resource_topics, null)
}

output "resource_topics_authorization_rules" {
  description = "The service bus topics authorization rules created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic_authorization_rule#attributes-reference"
  sensitive   = true
  value       = try(module.service_bus[0].resource_topics_authorization_rules, null)
}

output "resource_topics_subscriptions" {
  description = "The service bus topic subscriptions created. More info: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription#attributes-reference"
  value       = try(module.service_bus[0].resource_topics_subscriptions, null)
}

output "service_bus_queues" {
  description = "The list of servicebus queues and it's id"
  value = try([for i in azurerm_servicebus_queue.queue : {
    name = i.name
    id   = i.id
  }], null)
}
