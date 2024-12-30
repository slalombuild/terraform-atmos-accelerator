output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace"
  value       = module.naming.log_analytics_workspace.name
}

output "log_analytics_workspace_rg_name" {
  description = "log analytics workspace resource group name"
  value       = data.azurerm_resource_group.la_rg.name
}
