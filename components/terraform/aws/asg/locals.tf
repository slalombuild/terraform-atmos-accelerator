locals {
  image_id          = try(data.aws_ami.default.id, var.image_id)
  subnet_ids        = data.aws_subnets.private.ids
  target_group_arns = var.alb_name != "" ? [one(data.aws_lb_target_group.alb[*].arn)] : []

  userdata = var.userdata_file != "" ? filebase64("${path.module}/userdata/${var.userdata_file}") : null
}
