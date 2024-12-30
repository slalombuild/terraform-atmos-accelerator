resource "azurerm_api_management_api" "api" {
  for_each = { for api in var.api : api.name => api }

  api_management_name   = azurerm_api_management.apim.name
  name                  = each.key
  resource_group_name   = data.azurerm_resource_group.apim_rg.name
  revision              = each.value.revision
  api_type              = each.value.api_type
  description           = each.value.description
  display_name          = "${azurerm_api_management.apim.name}-${each.key}"
  path                  = each.value.path
  protocols             = each.value.protocols
  revision_description  = each.value.revision_description
  service_url           = each.value.service_url
  soap_pass_through     = each.value.soap_pass_through
  source_api_id         = each.value.source_api_id
  subscription_required = each.value.subscription_required
  terms_of_service_url  = each.value.terms_of_service_url
  version               = each.value.version
  version_description   = each.value.version_description
  version_set_id        = each.value.version_set_id

  dynamic "contact" {
    for_each = each.value.contact != null ? [each.value.contact] : []

    content {
      email = contact.value.email
      name  = contact.value.account_name
      url   = contact.value.url
    }
  }
  dynamic "import" {
    for_each = each.value.import != null ? [each.value.import] : []

    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value

      dynamic "wsdl_selector" {
        for_each = import.value.wsdl_selector != null ? [import.value.wsdl_selector] : []

        content {
          endpoint_name = wsdl_selector.value.endpoint_name
          service_name  = wsdl_selector.value.service_name
        }
      }
    }
  }
  dynamic "license" {
    for_each = each.value.license != null ? [each.value.license] : []

    content {
      name = license.value.name
      url  = license.value.url
    }
  }
  dynamic "oauth2_authorization" {
    for_each = each.value.oauth2_authorization != null ? [each.value.oauth2_authorization] : []

    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope                     = oauth2_authorization.value.scope
    }
  }
  dynamic "openid_authentication" {
    for_each = each.value.openid_authentication != null ? [each.value.openid_authentication] : []

    content {
      openid_provider_name         = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = openid_authentication.value.bearer_token_sending_methods
    }
  }
  dynamic "subscription_key_parameter_names" {
    for_each = each.value.subscription_key_parameter_names != null ? [each.value.subscription_key_parameter_names] : []

    content {
      header = subscription_key_parameter_names.value.header
      query  = subscription_key_parameter_names.value.query
    }
  }
}

#################
# Api Operation #
#################

resource "azurerm_api_management_api_operation" "api" {
  for_each = { for operation in var.api_operation : operation.operation_id => operation }

  api_management_name = azurerm_api_management.apim.name
  api_name            = azurerm_api_management_api.api[each.value.api_name].name
  display_name        = "${azurerm_api_management.apim.name}-${each.key}"
  method              = each.value.method
  operation_id        = each.key
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  url_template        = each.value.url_template
  description         = try(each.value.description, null)

  dynamic "request" {
    for_each = each.value.request != null ? [each.value.request] : []

    content {
      description = try(request.value.description, null)

      dynamic "header" {
        for_each = try(request.value.headers, {})

        content {
          name          = header.value.name
          required      = header.value.required
          type          = header.value.type
          default_value = try(header.value.default_value, null)
          description   = try(header.value.description, null)
          schema_id     = try(header.value.schema_id, null)
          type_name     = try(header.value.type_name, null)
          values        = try(header.value.values, null)

          dynamic "example" {
            for_each = try(header.value.examples, {})

            content {
              name           = example.value.name
              description    = try(example.value.description, null)
              external_value = try(example.value.external_value, null)
              summary        = try(example.value.summary, null)
              value          = try(example.value.value, null)
            }
          }
        }
      }
      dynamic "query_parameter" {
        for_each = try(request.value.query_parameters, {})

        content {
          name          = query_parameter.value.name
          required      = query_parameter.value.required
          type          = query_parameter.value.type
          default_value = try(query_parameter.value.default_value, null)
          description   = try(query_parameter.value.description, null)
          schema_id     = try(query_parameter.value.schema_id, null)
          type_name     = try(query_parameter.value.type_name, null)
          values        = try(query_parameter.value.values, null)

          dynamic "example" {
            for_each = try(query_parameter.value.examples, {})

            content {
              name           = example.value.name
              description    = try(example.value.description, null)
              external_value = try(example.value.external_value, null)
              summary        = try(example.value.summary, null)
              value          = try(example.value.value, null)
            }
          }
        }
      }
      dynamic "representation" {
        for_each = try(request.value.representations, {})

        content {
          content_type = representation.value.content_type
          schema_id    = try(representation.value.schema_id, null)
          type_name    = try(representation.value.type_name, null)

          dynamic "example" {
            for_each = try(representation.value.examples, {})

            content {
              name           = try(example.value.name, null)
              description    = try(example.value.description, null)
              external_value = try(example.value.external_value, null)
              summary        = try(example.value.summary, null)
              value          = try(example.value.value, null)
            }
          }
          dynamic "form_parameter" {
            for_each = try(representation.value.form_parameters, {})

            content {
              name          = form_parameter.value.name
              required      = form_parameter.value.required
              type          = form_parameter.value.type
              default_value = try(form_parameter.value.default_value, null)
              description   = try(form_parameter.value.description, null)
              schema_id     = try(form_parameter.value.schema_id, null)
              type_name     = try(form_parameter.value.type_name, null)
              values        = try(form_parameter.value.values, null)

              dynamic "example" {
                for_each = try(form_parameter.value.examples, {})

                content {
                  name           = example.value.name
                  description    = try(example.value.description, null)
                  external_value = try(example.value.external_value, null)
                  summary        = try(example.value.summary, null)
                  value          = try(example.value.value, null)
                }
              }
            }
          }
        }
      }
    }
  }
  dynamic "response" {
    for_each = try(each.value.responses, {})

    content {
      status_code = response.value.status_code
      description = try(response.value.description, null)

      dynamic "header" {
        for_each = try(response.value.headers, {})

        content {
          name          = header.value.name
          required      = header.value.required
          type          = header.value.type
          default_value = try(header.value.default_value, null)
          description   = try(header.value.description, null)
          schema_id     = try(header.value.schema_id, null)
          type_name     = try(header.value.type_name, null)
          values        = try(header.value.values, null)

          dynamic "example" {
            for_each = try(header.value.examples, {})

            content {
              name           = example.value.name
              description    = try(example.value.description, null)
              external_value = try(example.value.external_value, null)
              summary        = try(example.value.summary, null)
              value          = try(example.value.value, null)
            }
          }
        }
      }
      dynamic "representation" {
        for_each = try(response.value.representations, {})

        content {
          content_type = representation.value.content_type
          schema_id    = try(representation.value.schema_id, null)
          type_name    = try(representation.value.type_name, null)

          dynamic "example" {
            for_each = try(representation.value.examples, {})

            content {
              name           = try(example.value.name, null)
              description    = try(example.value.description, null)
              external_value = try(example.value.external_value, null)
              summary        = try(example.value.summary, null)
              value          = try(example.value.value, null)
            }
          }
          dynamic "form_parameter" {
            for_each = try(representation.value.form_parameters, {})

            content {
              name          = form_parameter.value.name
              required      = form_parameter.value.required
              type          = form_parameter.value.type
              default_value = try(form_parameter.value.default_value, null)
              description   = try(form_parameter.value.description, null)
              schema_id     = try(form_parameter.value.schema_id, null)
              type_name     = try(form_parameter.value.type_name, null)
              values        = try(form_parameter.value.values, null)

              dynamic "example" {
                for_each = try(form_parameter.value.examples, {})

                content {
                  name           = example.value.name
                  description    = try(example.value.description, null)
                  external_value = try(example.value.external_value, null)
                  summary        = try(example.value.summary, null)
                  value          = try(example.value.value, null)
                }
              }
            }
          }
        }
      }
    }
  }
  dynamic "template_parameter" {
    for_each = try(each.value.template_parameters, {})

    content {
      name          = template_parameter.value.name
      required      = template_parameter.value.required
      type          = template_parameter.value.type
      default_value = try(template_parameter.value.default_value, null)
      description   = try(template_parameter.value.description, null)
      schema_id     = try(template_parameter.value.schema_id, null)
      type_name     = try(template_parameter.value.type_name, null)
      values        = try(template_parameter.value.values, null)

      dynamic "example" {
        for_each = try(template_parameter.value.examples, {})

        content {
          name           = example.value.name
          description    = try(example.value.description, null)
          external_value = try(example.value.external_value, null)
          summary        = try(example.value.summary, null)
          value          = try(example.value.value, null)
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = contains(["GET", "DELETE", "PUT", "POST"], each.value.method)
      error_message = format("Enter a valid value for method: GET, DELETE, PUT, POST. Got: %s", each.value.method)
    }
  }
}

########################
# Api Operation Policy #
########################

resource "azurerm_api_management_api_operation_policy" "api" {
  for_each = { for policy in var.api_operation_policy : policy.operation_id => policy }

  api_management_name = azurerm_api_management.apim.name
  api_name            = azurerm_api_management_api.api[each.value.api_name].name
  operation_id        = azurerm_api_management_api_operation.api[each.key].operation_id
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  xml_content         = each.value.xml_content
  xml_link            = each.value.xml_link
}
