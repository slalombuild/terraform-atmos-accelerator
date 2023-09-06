locals {
  enabled               = module.this.enabled
  account_id            = one(data.aws_caller_identity.current[*].account_id)
  vpc_cidr              = data.aws_vpc.main.cidr_block
  region                = var.region
  lambda_function_names = var.lambda_function_names
  open_api_config       = var.openapi_config != null ? var.openapi_config : yamldecode(templatefile("./openapi-doc/${var.open_api_file_name}", {}))

  private_api_policy = one(data.aws_iam_policy_document.rest_api_policy[*].json)
  create_api_policy  = var.endpoint_type == "PRIVATE" && var.rest_api_policy == null ? true : false
  api_policy = var.rest_api_policy != null ? var.rest_api_policy : jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "execute-api:Invoke"
        ]
        Effect    = "Allow"
        Principal = "*"
        Resource  = "arn:aws:execute-api:${local.region}:${local.account_id}:*/*/*/*"
      }
    ]
  })
}

data "aws_iam_policy_document" "rest_api_policy" {
  count = local.enabled && local.create_api_policy ? 1 : 0
  statement {
    actions = ["execute-api:Invoke"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    effect    = "Allow"
    resources = ["arn:aws:execute-api:${local.region}:${local.account_id}:*"]
  }
  statement {
    actions = ["execute-api:Invoke"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    effect    = "Allow"
    resources = ["arn:aws:execute-api:${local.region}:${local.account_id}:*"]
    condition {
      test     = "NotIpAddress"
      variable = "aws:SourceIp"
      values   = [local.vpc_cidr]
    }
  }
}

module "api_gateway" {
  source  = "cloudposse/api-gateway/aws"
  version = "0.3.1"

  openapi_config           = local.open_api_config
  endpoint_type            = var.endpoint_type
  logging_level            = var.logging_level
  permissions_boundary     = var.permissions_boundary
  stage_name               = var.stage_name
  rest_api_policy          = local.private_api_policy != "" ? local.private_api_policy : local.api_policy
  metrics_enabled          = var.metrics_enabled
  xray_tracing_enabled     = var.xray_tracing_enabled
  access_log_format        = var.access_log_format
  private_link_target_arns = var.private_link_target_arns
  iam_tags_enabled         = var.iam_tags_enabled

  context = module.this.context
}

resource "aws_lambda_permission" "allow_apigateway_invoke_lambda" {
  for_each = local.enabled && length(local.lambda_function_names) > 0 ? local.lambda_function_names : toset([])

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.key
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.execution_arn}/*/*"
}

module "api_gateway_account_settings" {
  count   = local.enabled && var.api_gateway_account_settings_enabled ? 1 : 0
  source  = "cloudposse/api-gateway/aws//modules/account-settings"
  version = "0.3.1"

  name                 = "apigateway-settings"
  permissions_boundary = var.permissions_boundary
  iam_tags_enabled     = var.iam_tags_enabled
  iam_role_arn         = var.iam_role_arn
  context              = module.this.context
}
