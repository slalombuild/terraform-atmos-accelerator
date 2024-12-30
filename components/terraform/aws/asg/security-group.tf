# Auto-scaling security group

resource "aws_security_group" "asg" {
  description = "security group for asg"
  name        = format("%s-%s-asg-sg-%s", var.namespace, var.environment, var.name)
  vpc_id      = data.aws_vpc.main.id
}

# We separate the rules from the aws_security_group because then we can manipulate the
# aws_security_group outside of this module
resource "aws_security_group_rule" "outbound_internet_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.asg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.egress_cidrs
}

variable "enable_asg_icmp" {
  type        = bool
  description = "whether to create ICMP role"
  default     = false
}

resource "aws_security_group_rule" "allow_icmp_ingress" {
  count = var.enable_asg_icmp ? 1 : 0

  from_port         = 8
  protocol          = "icmp"
  security_group_id = aws_security_group.asg.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.asg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.ssh_ingress_cidrs
}


data "aws_security_group" "alb" {
  count = var.alb_name != "" ? 1 : 0

  name = "${var.namespace}-${var.environment}-${var.alb_name}"
}
resource "aws_security_group_rule" "allow_http_ingress" {
  count = var.alb_name != "" ? 1 : 0

  from_port                = var.service_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.asg.id
  to_port                  = var.service_port
  type                     = "ingress"
  source_security_group_id = one(data.aws_security_group.alb[*].id)
}
