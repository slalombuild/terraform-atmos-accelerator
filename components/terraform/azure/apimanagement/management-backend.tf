resource "azurerm_api_management_backend" "apim" {
  for_each = { for backend in var.apim_backend : backend.name => backend }

  api_management_name = azurerm_api_management.apim.name
  name                = "${azurerm_api_management.apim.name}-${each.key}"
  protocol            = each.value.protocol
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  url                 = each.value.backend_url
  description         = try(each.value.description, null)
  resource_id         = try(each.value.resource_id, null)
  title               = try(each.value.title, null)

  dynamic "credentials" {
    for_each = try(each.value.credentials, null) != null ? [each.value.credentials] : []

    content {
      certificate = try(credentials.value.certificate, null)
      header      = try(credentials.value.header, null)
      query       = try(credentials.value.query, null)

      dynamic "authorization" {
        for_each = try(each.value.authorization, null) != null ? [each.value.authorization] : []

        content {
          parameter = try(authorization.value.parameter, null)
          scheme    = try(authorization.value.scheme, null)
        }
      }
    }
  }
  dynamic "proxy" {
    for_each = try(each.value.proxy, null) != null ? [each.value.proxy] : []

    content {
      url      = try(proxy.value.url, null)
      username = try(proxy.value.username, null)
      password = try(proxy.value.password, null)
    }
  }
  dynamic "service_fabric_cluster" {
    for_each = try(each.value.service_fabric_cluster, null) != null ? [each.value.service_fabric_cluster] : []

    content {
      management_endpoints             = try(service_fabric_cluster.value.management_endpoints, null)
      max_partition_resolution_retries = try(service_fabric_cluster.value.max_partition_resolution_retries, null)
      client_certificate_id            = try(service_fabric_cluster.value.client_certificate_id, null)
      client_certificate_thumbprint    = try(service_fabric_cluster.value.client_certificate_thumbprint, null)
      server_certificate_thumbprints   = try(service_fabric_cluster.value.server_certificate_thumbprints, null)

      dynamic "server_x509_name" {
        for_each = try(each.value.server_x509_name, null) != null ? [each.value.server_x509_name] : []

        content {
          issuer_certificate_thumbprint = try(server_x509_name.value.issuer_certificate_thumbprint, null)
          name                          = try(server_x509_name.value.name, null)
        }
      }
    }
  }
  dynamic "tls" {
    for_each = try(each.value.tls, null) != null ? [each.value.tls] : []

    content {
      validate_certificate_chain = try(tls.value.validate_certificate_chain, null)
      validate_certificate_name  = try(tls.value.validate_certificate_name, null)
    }
  }
}
