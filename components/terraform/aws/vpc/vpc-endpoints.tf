locals {
  enabled = var.enable_vpc_endpoints
  gateway_vpc_endpoints = {
    "s3" = {
      name = "s3"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "s3:*",
            ]
            Effect    = "Allow"
            Principal = "*"
            Resource  = "*"
          },
        ]
      })
    }
    "dynamodb" = {
      name   = "dynamodb"
      policy = null
    }
  }
  interface_vpc_endpoints = {
    "ec2" = {
      name                = "ec2"
      security_group_ids  = [one(aws_security_group.ec2_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "kinesis-streams" = {
      name                = "kinesis-streams"
      security_group_ids  = [one(aws_security_group.kinesis_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "ecs" = {
      name                = "ecs"
      security_group_ids  = [one(aws_security_group.ecs_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "execute-api" = {
      name                = "execute-api"
      security_group_ids  = [one(aws_security_group.execute_api_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "secretsmanager" = {
      name                = "secretsmanager"
      security_group_ids  = [one(aws_security_group.secretsmanager_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "ssm" = {
      name                = "ssm"
      security_group_ids  = [one(aws_security_group.ssm_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "sqs" = {
      name                = "sqs"
      security_group_ids  = [one(aws_security_group.sqs_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "ecr.api" = {
      name                = "ecr.api"
      security_group_ids  = [one(aws_security_group.ecr_api_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
    "ecr.dkr" = {
      name                = "ecr.dkr"
      security_group_ids  = [one(aws_security_group.ecr_dkr_vpc_endpoint_sg[*].id)]
      subnet_ids          = module.subnets.private_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
  }
}

/*
Endpoints
*/
module "vpc_endpoints" {
  source  = "cloudposse/vpc/aws//modules/vpc-endpoints"
  version = "v2.1.0"
  enabled = local.enabled
  vpc_id  = module.vpc.vpc_id

  gateway_vpc_endpoints   = local.gateway_vpc_endpoints
  interface_vpc_endpoints = local.interface_vpc_endpoints

  context = module.this.context
}

#Security groups

module "ec2_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["ec2-vpc-endpoint-sg"]

  context = module.this.context
}

module "ecs_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["ecs-vpc-endpoint-sg"]

  context = module.this.context
}

module "execute_api_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["execute_api-vpc-endpoint-sg"]

  context = module.this.context
}

module "secretsmanager_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["secretsmanager-vpc-endpoint-sg"]

  context = module.this.context
}

module "ssm_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["ssm-vpc-endpoint-sg"]

  context = module.this.context
}

module "kinesis_vpc_endpoint_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["kinesis-vpc-endpoint-sg"]

  context = module.this.context
}

module "sqs_vpc_endpoint_sg_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["sqs-vpc-endpoint-sg"]
  context    = module.this.context
}

module "ecr_api_vpc_endpoint_sg_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["ecr-api-vpc-endpoint-sg"]
  context    = module.this.context
}

module "ecr_dkr_vpc_endpoint_sg_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["ecr-dkr-vpc-endpoint-sg"]
  context    = module.this.context
}

resource "aws_security_group" "ec2_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for EC2 Interface VPC Endpoint"
  }

  tags = module.ec2_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "ecs_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for ECS Interface VPC Endpoint"
  }

  tags = module.ecs_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "execute_api_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for Execute API Interface VPC Endpoint"
  }

  tags = module.execute_api_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "secretsmanager_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for Secrets Manager Interface VPC Endpoint"
  }

  tags = module.secretsmanager_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "ssm_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for SSM Interface VPC Endpoint"
  }

  tags = module.ssm_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "kinesis_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for Kinesis Interface VPC Endpoint"
  }

  tags = module.kinesis_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "sqs_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for SQS Interface VPC Endpoint"
  }

  tags = module.sqs_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "ecr_api_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for ECR API Interface VPC Endpoint"
  }

  tags = module.ecr_api_vpc_endpoint_sg_label.tags
}

resource "aws_security_group" "ecr_dkr_vpc_endpoint_sg" {
  count  = local.enabled ? 1 : 0
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "Security Group for ECR DKR Interface VPC Endpoint"
  }

  tags = module.ecr_dkr_vpc_endpoint_sg_label.tags
}

/*
Endpoint route table association
*/

locals {
  route_tables = concat(module.subnets.private_route_table_ids, module.subnets.public_route_table_ids)
}
resource "aws_vpc_endpoint_route_table_association" "s3_gateway_vpc_endpoint_route_table_association" {
  count           = local.enabled ? length(local.route_tables) : 0
  route_table_id  = local.route_tables[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[0].id
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_gateway_vpc_endpoint_route_table_association" {
  count           = local.enabled ? length(local.route_tables) : 0
  route_table_id  = local.route_tables[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[1].id
}
