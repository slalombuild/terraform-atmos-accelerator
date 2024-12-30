# Instance security group
resource "aws_security_group" "instance" {
  description = "security group for ec2"
  name        = format("%s-%s-ec2-sg-%s", var.namespace, var.environment, var.name)
  vpc_id      = data.aws_vpc.main.id
}

variable "egress_cidrs" {
  type        = list(string)
  description = "Egress cidr to allow the instance to connect to"
  default     = []
}

# We separate the rules from the aws_security_group because then we can manipulate the
# aws_security_group outside of this module
resource "aws_security_group_rule" "outbound_internet_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.instance.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.egress_cidrs
}

variable "enable_instance_icmp" {
  type        = bool
  description = "whether to create ICMP role"
  default     = false
}

resource "aws_security_group_rule" "allow_icmp_ingress" {
  count = var.enable_instance_icmp ? 1 : 0

  from_port         = 8
  protocol          = "icmp"
  security_group_id = aws_security_group.instance.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.instance.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.ssh_ingress_cidrs
}
