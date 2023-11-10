module "vpc" {
  version                          = "2.1.1"
  source                           = "cloudposse/vpc/aws"
  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
  assign_generated_ipv6_cidr_block = true

  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  availability_zones  = var.availability_zones
  vpc_id              = module.vpc.vpc_id
  igw_id              = [module.vpc.igw_id]
  nat_gateway_enabled = var.nat_gateway_enabled
  ipv4_cidrs          = var.ipv4_cidrs
  context             = module.this.context
}

resource "aws_route" "private_vpn_tgw" {
  count = var.transit_gateway_id != "" ? length(module.subnets.private_route_table_ids) : 0

  route_table_id         = module.subnets.private_route_table_ids[count.index]
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = var.transit_gateway_id

}
