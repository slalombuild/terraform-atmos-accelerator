data "azurerm_function_app_host_keys" "host_keys" {
  count = length(var.api_management_backends) > 0 ? 1 : 0

  name                = azurerm_windows_function_app.windows_function.name
  resource_group_name = azurerm_windows_function_app.windows_function.resource_group_name
}

resource "azurerm_api_management_backend" "backend" {
  for_each = length(var.api_management_backends) > 0 ? { for backend, _ in var.api_management_backends : backend => _ } : {}

  api_management_name = replace(replace(module.apim_naming[each.key].api_management.name, module.this.environment, "-${module.this.environment}-"), each.value.apim_name, "${each.value.apim_name}-")
  name                = each.value.backend_name != null ? each.value.backend_name : module.this.name
  protocol            = "http"
  resource_group_name = module.apim_naming[each.key].resource_group.name
  url                 = "https://${azurerm_windows_function_app.windows_function.default_hostname}${each.value.backend_path}"

  credentials {
    header = {
      "x-functions-key" = "${data.azurerm_function_app_host_keys.host_keys[0].default_function_key}"
    }
  }
}
