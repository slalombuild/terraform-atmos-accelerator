data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

# If you know the tags of your existing VPC you can search for it this way
#TODO: this data lookup assumes vpc names in the format {namespace}-{environment}-vpc if multiples vpcs are expected to be deployed
# this data lookup will need to be adjusted and maybe add a input var on the module like var.vpc_name to add to the format instead of vpc
data "aws_vpc" "main" {
  count = var.vpc_config != null ? 1 : 0

  tags = {
    Name = format("%s-%s-%s", var.namespace, var.environment, var.stage)
  }
}

data "aws_subnets" "private" {
  count = var.vpc_config != null ? 1 : 0

  tags = {
    Name = "*private*"
  }

  filter {
    name   = "vpc-id"
    values = [one(data.aws_vpc.main.*.id)]
  }
}
