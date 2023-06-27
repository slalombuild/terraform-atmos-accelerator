output "alias_arn" {
  value       = module.kms_key.alias_arn
  description = "Alias ARN"
}

output "name" {
  value       = module.kms_key.name
  description = "Alias name"
}

output "kms_policy_json" {
  value = var.create ? data.aws_iam_policy_document.this.json : null
}
