locals {
  enabled    = module.this.enabled
  vpc_id     = data.aws_vpc.main.id
  subnet_ids = data.aws_subnets.private.ids
  vpc_cidr   = data.aws_vpc.main.cidr_block
  # Lambda Config
  lambda_s3_key = var.s3_key == null ? var.package_name : var.s3_key
  package_name  = var.package_name
}
