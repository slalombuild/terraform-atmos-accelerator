locals {
  vpc_id   = data.aws_vpc.main.id
  subnet   = data.aws_subnets.private.ids[0]
  image_id = data.aws_ami.default.id

  userdata = var.userdata_file != "" ? filebase64("${path.module}/userdata/${var.userdata_file}") : null
}
