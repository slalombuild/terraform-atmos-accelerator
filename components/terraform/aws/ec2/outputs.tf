output "additional_eni_ids" {
  description = "Map of ENI to EIP"
  value       = module.ec2_instance.additional_eni_ids
}

output "arn" {
  description = "ARN of the instance"
  value       = module.ec2_instance.arn
}

output "ebs_ids" {
  description = "IDs of EBSs"
  value       = module.ec2_instance.ebs_ids
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.ec2_instance.id
}

output "name" {
  description = "Instance name"
  value       = module.ec2_instance.name
}

output "primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = module.ec2_instance.primary_network_interface_id
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.ec2_instance.private_dns
}

output "private_ip" {
  description = "Private IP of instance"
  value       = module.ec2_instance.private_ip
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = module.ec2_instance.public_dns
}

output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = module.ec2_instance.public_ip
}

output "role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = module.ec2_instance.role
}

output "security_group_arn" {
  description = "EC2 instance Security Group ARN"
  value       = module.ec2_instance.security_group_arn
}

output "security_group_id" {
  description = "EC2 instance Security Group ID"
  value       = module.ec2_instance.security_group_id
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value       = module.ec2_instance.security_group_ids
}

output "security_group_name" {
  description = "EC2 instance Security Group name"
  value       = module.ec2_instance.security_group_name
}

output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = module.ec2_instance.ssh_key_pair
}
