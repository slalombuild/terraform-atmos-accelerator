data "aws_iam_policy_document" "costexplorer_access" {
  statement {
    actions = [
      "cost-optimization-hub:ListEnrollmentStatuses",
      "cost-optimization-hub:UpdateEnrollmentStatus",
      "cost-optimization-hub:GetPreferences",
      "cost-optimization-hub:UpdatePreferences",
      "cost-optimization-hub:GetRecommendations",
      "cost-optimization-hub:ListRecommendations",
      "cost-optimization-hub:ListRecommendationSummaries",
      "organizations:DescribeOrganization",
      "organizations:ListAccounts",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:ListParents",
      "organizations:DescribeOrganizationalUnit",
      "ce:ListCostAllocationTags",
      "ce:GetCostAndUsage",
      "ce:GetCostForecast",
      "ce:GetReservationUtilization",
      "ce:GetReservationPurchaseRecommendation",
      "ce:DescribeReport",
      "ce:GetDimensionValues",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
    sid = "AllowDNS"
  }
}

locals {
  billing_read_only_access_permission_set = [{
    name             = "BillingReadOnlyAccess",
    description      = "Allow users to view bills in the billing console",
    relay_state      = "",
    session_duration = "",
    tags             = {},
    inline_policy    = data.aws_iam_policy_document.costexplorer_access.json,
    policy_attachments = [
      "arn:${local.aws_partition}:iam::aws:policy/AWSBillingReadOnlyAccess",
      "arn:${local.aws_partition}:iam::aws:policy/AWSSupportAccess",
    ]
    customer_managed_policy_attachments = []
  }]
}
