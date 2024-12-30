output "additional_cidr_blocks" {
  description = "A list of the additional IPv4 CIDR blocks associated with the VPC"
  value       = module.vpc.additional_cidr_blocks
}

output "additional_cidr_blocks_to_association_ids" {
  description = "A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs"
  value       = module.vpc.additional_cidr_blocks_to_association_ids
}

output "additional_ipv6_cidr_blocks" {
  description = "A list of the additional IPv4 CIDR blocks associated with the VPC"
  value       = module.vpc.additional_ipv6_cidr_blocks
}

output "additional_ipv6_cidr_blocks_to_association_ids" {
  description = "A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs"
  value       = module.vpc.additional_ipv6_cidr_blocks_to_association_ids
}

output "availability_zones" {
  description = "List of Availability Zones where subnets were created"
  value       = module.subnets.availability_zones
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "ipv6_cidr_block_network_border_group" {
  description = "The IPv6 Network Border Group Zone name"
  value       = module.vpc.ipv6_cidr_block_network_border_group
}

output "ipv6_egress_only_igw_id" {
  description = "The ID of the egress-only Internet Gateway"
  value       = module.vpc.ipv6_egress_only_igw_id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways created"
  value       = module.subnets.nat_gateway_ids
}

output "nat_ips" {
  description = "Elastic IP Addresses in use by NAT"
  value       = module.subnets.nat_ips
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.subnets.private_route_table_ids
}

output "private_subnet_cidrs" {
  description = "IPv4 CIDR blocks of the created private subnets"
  value       = module.subnets.private_subnet_cidrs
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = module.subnets.private_subnet_ids
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.subnets.public_route_table_ids
}

output "public_subnet_cidrs" {
  description = "IPv4 CIDR blocks of the created public subnets"
  value       = module.subnets.public_subnet_cidrs
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = module.subnets.public_subnet_ids
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr" {
  description = "The primary IPv4 CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = module.vpc.vpc_default_network_acl_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = module.vpc.vpc_default_route_table_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.vpc_default_security_group_id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the primary IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_association_id
}

output "vpc_ipv6_cidr_block" {
  description = "The primary IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_cidr_block
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = module.vpc.vpc_main_route_table_id
}
