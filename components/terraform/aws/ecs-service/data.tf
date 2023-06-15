data "aws_ssm_parameter" "oid_client_secret" {
  count = var.authentication_oidc_client_secret != "" ? 1 : 0
  name  = format("/%s", var.authentication_oidc_client_secret)
}

data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_vpc" "selected" {
  count = local.enabled ? 1 : 0
  tags = {
    Name = format("%s-%s-%s", var.namespace, var.environment, var.vpc_name)
  }
}

data "aws_security_group" "vpc_default" {
  count = local.enabled ? 1 : 0

  name = "default"

  vpc_id = local.vpc_id

  tags = local.match_tags
}

data "aws_subnets" "selected" {
  count = local.enabled ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  tags = merge(local.match_tags, local.subnet_match_tags)
}

data "aws_iam_policy_document" "this" {
  count = var.iam_policy_enabled ? 1 : 0

  dynamic "statement" {
    # Only flatten if a list(string) is passed in, otherwise use the map var as-is
    for_each = try(flatten(var.iam_policy_statements), var.iam_policy_statements)

    content {
      sid    = lookup(statement.value, "sid", statement.key)
      effect = lookup(statement.value, "effect", null)

      actions     = lookup(statement.value, "actions", null)
      not_actions = lookup(statement.value, "not_actions", null)

      resources     = lookup(statement.value, "resources", null)
      not_resources = lookup(statement.value, "not_resources", null)

      dynamic "principals" {
        for_each = lookup(statement.value, "principals", [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = lookup(statement.value, "not_principals", [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = lookup(statement.value, "conditions", [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

data "aws_security_group" "rds" {
  count = local.enabled && var.use_rds_client_sg ? 1 : 0

  vpc_id = local.vpc_id

  tags = {
    "Name" = module.rds_sg_label.id
  }
}

data "aws_ecs_cluster" "selected" {
  count = local.enabled ? 1 : 0

  cluster_name = coalesce(var.cluster_full_name, module.ecs_label.id)
}

data "aws_security_group" "lb" {
  count = local.enabled ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(local.match_tags, local.lb_match_tags)
}

data "aws_lb" "selected" {
  count = local.enabled ? 1 : 0

  tags = merge(local.match_tags, local.lb_match_tags)
}

data "aws_lb_listener" "selected_https" {
  count = local.enabled ? 1 : 0

  load_balancer_arn = local.lb_arn
  port              = 443
}

# This is purely a check to ensure this zone exists
data "aws_route53_zone" "selected" {
  count = local.enabled ? 1 : 0

  name         = local.zone_domain
  private_zone = false
}

data "aws_kms_alias" "selected" {
  count = local.enabled && var.kinesis_enabled ? 1 : 0
  name  = format("alias/%s", coalesce(var.kms_key_alias, var.name))
}
