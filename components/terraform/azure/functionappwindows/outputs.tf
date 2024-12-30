output "function_app_id" {
  description = "Function app id"
  value       = azurerm_windows_function_app.windows_function.id
}

output "function_app_name" {
  description = "Function app name"
  value       = azurerm_windows_function_app.windows_function.name
}

output "function_app_principal_id" {
  description = "Function app principal ID"
  sensitive   = true
  value       = azurerm_windows_function_app.windows_function.identity[0].principal_id
}

output "function_app_rg_name" {
  description = "Function app resource group name"
  value       = data.azurerm_resource_group.func_rg.name
}

output "function_app_slot_id" {
  description = "Function app slot id"
  value       = var.staging_slot_enabled ? azurerm_windows_function_app_slot.windows_function_slot[0].id : null
}

output "function_app_slot_name" {
  description = "Function App Slot name"
  value       = var.staging_slot_enabled ? azurerm_windows_function_app_slot.windows_function_slot[0].name : null
}

output "function_app_staging_slot_principal_id" {
  description = "Function app Staging Slot principal ID"
  sensitive   = true
  value       = var.staging_slot_enabled ? azurerm_windows_function_app_slot.windows_function_slot[0].identity[0].principal_id : null
}
