output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = module.ec2_instance.public_ip
}

output "private_ip" {
  description = "Private IP of instance"
  value       = module.ec2_instance.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.ec2_instance.private_dns
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = module.ec2_instance.public_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.ec2_instance.id
}

output "arn" {
  description = "ARN of the instance"
  value       = module.ec2_instance.arn
}

output "name" {
  description = "Instance name"
  value       = module.ec2_instance.name
}

output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = module.ec2_instance.ssh_key_pair
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value       = module.ec2_instance.security_group_ids
}

output "role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = module.ec2_instance.role
}

output "additional_eni_ids" {
  description = "Map of ENI to EIP"
  value       = module.ec2_instance.additional_eni_ids
}

output "ebs_ids" {
  description = "IDs of EBSs"
  value       = module.ec2_instance.ebs_ids
}

output "primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = module.ec2_instance.primary_network_interface_id
}

output "security_group_id" {
  value       = module.ec2_instance.security_group_id
  description = "EC2 instance Security Group ID"
}

output "security_group_arn" {
  value       = module.ec2_instance.security_group_arn
  description = "EC2 instance Security Group ARN"
}

output "security_group_name" {
  value       = module.ec2_instance.security_group_name
  description = "EC2 instance Security Group name"
}
