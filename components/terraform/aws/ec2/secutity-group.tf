# Instance security group
resource "aws_security_group" "instance" {
  name        = format("%s-%s-ec2-sg-%s", var.namespace, var.environment, var.name)
  description = "security group for ec2"
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
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.egress_cidrs
  security_group_id = aws_security_group.instance.id
}

variable "enable_instance_icmp" {
  type        = bool
  description = "whether to create ICMP role"
  default     = false
}

resource "aws_security_group_rule" "allow_icmp_ingress" {
  count             = var.enable_instance_icmp ? 1 : 0
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = aws_security_group.instance.id
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_ingress_cidrs
  security_group_id = aws_security_group.instance.id
}
