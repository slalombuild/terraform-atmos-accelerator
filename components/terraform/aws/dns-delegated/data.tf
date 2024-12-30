data "aws_route53_zone" "root_zone" {
  provider = aws.primary
  for_each = local.enabled ? local.zone_map : {}

  name         = format("%s.", each.value)
  private_zone = false
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

# If you know the tags of your existing VPC you can searh for it this way
data "aws_vpc" "main" {
  tags = {
    Name = format("%s-%s-%s", var.namespace, var.environment, var.vpc_name)
  }
}
