output "app_insights_app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = azurerm_application_insights.app_insights.app_id
}

output "app_insights_id" {
  description = "The ID of the Application Insights component."
  value       = azurerm_application_insights.app_insights.id
}

output "connection_string" {
  description = "The Connection String for this Application Insights component. (Sensitive)"
  sensitive   = true
  value       = azurerm_application_insights.app_insights.connection_string
}

output "instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights component. (Sensitive)"
  sensitive   = true
  value       = azurerm_application_insights.app_insights.instrumentation_key
}

output "la_primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  sensitive   = true
  value       = try(azurerm_log_analytics_workspace.this[0].primary_shared_key, null)
}

output "la_secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  sensitive   = true
  value       = try(azurerm_log_analytics_workspace.this[0].secondary_shared_key, null)
}

output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  value       = try(azurerm_log_analytics_workspace.this[0].id, null)
}
