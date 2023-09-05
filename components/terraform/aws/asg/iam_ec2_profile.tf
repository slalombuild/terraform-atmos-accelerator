# ssm iam instance profile 

resource "aws_iam_instance_profile" "iam_profile" {
  name = format("%s-%s-ec2profile-%s", var.namespace, var.environment, var.name)
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role" "iam_role" {
  name               = format("%s-%s-ec2role-%s", var.namespace, var.environment, var.name)
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
}


locals {
  required_policies = ["AmazonSSMManagedInstanceCore"]
  all_policies      = toset(concat(var.custom_managed_policies, local.required_policies))
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each   = local.all_policies
  role       = aws_iam_role.iam_role.name
  policy_arn = format("arn:aws:iam::aws:policy/%s", each.key)
}
