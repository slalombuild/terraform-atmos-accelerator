# ssm iam instance profile

resource "aws_iam_instance_profile" "iam_profile" {
  name = format("%s-%s-ec2profile-%s", var.namespace, var.environment, var.name)
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": {
  "Effect": "Allow",
  "Principal": {"Service": "ec2.amazonaws.com"},
  "Action": "sts:AssumeRole"
  }
  }
  EOF
  name               = format("%s-%s-ec2role-%s", var.namespace, var.environment, var.name)
}


locals {
  all_policies      = toset(concat(var.custom_managed_policies, local.required_policies))
  required_policies = ["AmazonSSMManagedInstanceCore"]
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = local.all_policies

  policy_arn = format("arn:aws:iam::aws:policy/%s", each.key)
  role       = aws_iam_role.iam_role.name
}
