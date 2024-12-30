locals {
  image_id = data.aws_ami.default.id
  subnet   = data.aws_subnets.private.ids[0]
  userdata = var.userdata_file != "" ? filebase64("${path.module}/userdata/${var.userdata_file}") : null
  vpc_id   = data.aws_vpc.main.id
}
