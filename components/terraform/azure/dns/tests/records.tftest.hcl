variables {
  domain_name = "${substr(md5(timestamp()), 0, 6)}example.com"
  location    = "westus3"
}

run "create_dns_records" {
  command = plan

  variables {
    location = var.location
    name     = "test"
    dns_zones = [
      {
        domain_name = var.domain_name
        private     = false
        recordset = [
          {
            name    = "www"
            type    = "a"
            ttl     = 3600
            records = ["1.2.3.4", "5.6.7.8"]
          },
          {
            name    = "aaaa"
            type    = "aaaa"
            ttl     = 3600
            records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]
          },
          {
            name   = "cname"
            type   = "cname"
            ttl    = 3600
            record = var.domain_name
          },
          {
            name    = "txt"
            type    = "txt"
            ttl     = 3600
            records = ["1.2.3.4"]
          },
          {
            name    = "ns"
            type    = "ns"
            ttl     = 3600
            records = ["1.2.3.4"]
          },
          {
            name = "mx"
            type = "mx"
            ttl  = 3600
            mx_records = [{
              exchange   = "mail.example.com"
              preference = 10
            }]
          },
        ]
      }
    ]
  }

  # Check that the public DNS zone is created
  assert {
    condition     = azurerm_dns_zone.public_dns["${var.domain_name}"] != null
    error_message = "Public DNS zone was not created"
  }

  # Check that the A records are created
  assert {
    condition     = azurerm_dns_a_record.a["${var.domain_name},a,www,[\"1.2.3.4\",\"5.6.7.8\"],3600"] != null
    error_message = "A records were not created"
  }

  # Check that the AAAA record is created
  assert {
    condition     = azurerm_dns_aaaa_record.aaaa["${var.domain_name},aaaa,aaaa,[\"2001:0db8:85a3:0000:0000:8a2e:0370:7334\"],3600"] != null
    error_message = "AAAA record was not created"
  }

  # Check that the CNAME record is created
  assert {
    condition     = azurerm_dns_cname_record.cname["${var.domain_name},cname,cname,${var.domain_name},3600"] != null
    error_message = "CNAME record was not created"
  }

  # Check that the TXT record is created
  assert {
    condition     = azurerm_dns_txt_record.txt["${var.domain_name},txt,txt,[\"1.2.3.4\"],3600"] != null
    error_message = "TXT record was not created"
  }

  # Check that the NS record is created
  assert {
    condition     = azurerm_dns_ns_record.ns["${var.domain_name},ns,ns,[\"1.2.3.4\"],3600"] != null
    error_message = "NS record was not created"
  }

  # Check that the MX record is created
  assert {
    condition     = azurerm_dns_mx_record.recordset_mx["${var.domain_name},mx,mx,3600"] != null
    error_message = "MX record was not created"
  }

  # Check that the resource group is created
  assert {
    condition     = azurerm_resource_group.rg[0] != null
    error_message = "Resource group was not created"
  }
}
