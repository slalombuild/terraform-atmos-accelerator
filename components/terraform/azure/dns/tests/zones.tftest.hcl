variables {
  domain_name = "${substr(md5(timestamp()), 0, 6)}example.com"
}

run "create_public_zone" {
  command = plan

  variables {
    location = "westus3"
    name     = "test"
    dns_zones = [
      {
        domain_name = var.domain_name
        private     = false
        recordset   = []
      }
    ]
  }

  # Check that the public DNS zone is created
  assert {
    condition     = azurerm_dns_zone.public_dns["${var.domain_name}"] != null
    error_message = "Public DNS zone was not created"
  }

  # Check that the resource group is created
  assert {
    condition     = azurerm_resource_group.rg[0] != null
    error_message = "Resource group was not created"
  }
}

run "create_private_zone" {
  command = plan

  variables {
    location = "westus3"
    name     = "test"
    dns_zones = [
      {
        domain_name = var.domain_name
        private     = true
        recordset   = []
      }
    ]
  }

  # Check that the private DNS zone is created
  assert {
    condition     = azurerm_private_dns_zone.private_dns["${var.domain_name}"] != null
    error_message = "Public DNS zone was not created"
  }

  # Check that the resource group is created
  assert {
    condition     = azurerm_resource_group.rg[0] != null
    error_message = "Resource group was not created"
  }
}
