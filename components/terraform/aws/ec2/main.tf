module "ec2_instance" {
  source                      = "cloudposse/ec2-instance/aws"
  version                     = "0.48.0"
  vpc_id                      = local.vpc_id
  subnet                      = local.subnet
  security_groups             = [aws_security_group.instance.id]
  assign_eip_address          = var.assign_eip_address
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  ami                         = local.image_id
  ami_owner                   = var.ami_owner
  security_group_rules        = var.security_group_rules
  instance_profile            = aws_iam_instance_profile.iam_profile.name
  user_data_base64            = local.userdata



  delete_on_termination        = var.delete_on_termination
  root_block_device_encrypted  = var.device_encrypted
  root_volume_size             = var.volume_size
  root_block_device_kms_key_id = var.device_kms_key_id
  root_volume_type             = var.volume_type
  root_iops                    = var.iops
  root_throughput              = var.throughput

  metadata_http_endpoint_enabled       = var.metadata_http_endpoint_enabled
  metadata_tags_enabled                = var.metadata_tags_enabled
  metadata_http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  metadata_http_tokens_required        = var.metadata_http_tokens_required

  context = module.this.context
}


