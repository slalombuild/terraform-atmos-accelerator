# If you know the tags of your existing VPC you can search for it this way
#TODO: this data lookup assumes vpc names in the format {namespace}-{environment}-vpc if multiples vpcs are expected to be deployed
# this data lookup will need to be adjusted and maybe add a input var on the module like var.vpc_name to add to the format instead of vpc
data "aws_vpc" "main" {
  tags = {
    Name = format("%s-%s-%s", var.namespace, var.environment, var.vpc_name)
  }
}

data "aws_subnets" "private" {
  tags = {
    Name = "*private*"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_ami" "default" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
