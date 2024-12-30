locals {
  eks_viewer_enabled = contains(local.configured_policies, "eks_viewer")
}

data "aws_iam_policy_document" "eks_view_access" {
  count = local.eks_viewer_enabled ? 1 : 0

  statement {
    actions = [
      "eks:Get*",
      "eks:Describe*",
      "eks:List*",
      "eks:Access*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
    sid = "AllowEKSView"
  }
}

data "aws_iam_policy_document" "eks_viewer_access_aggregated" {
  count = local.eks_viewer_enabled ? 1 : 0

  source_policy_documents = [
    data.aws_iam_policy_document.eks_view_access[0].json,
  ]
}

resource "aws_iam_policy" "eks_viewer" {
  count = local.eks_viewer_enabled ? 1 : 0

  policy = data.aws_iam_policy_document.eks_viewer_access_aggregated[0].json
  name   = format("%s-eks_viewer", module.this.id)
  tags   = module.this.tags
}
