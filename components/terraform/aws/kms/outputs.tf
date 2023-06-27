output "key_arn" {
  value       = module.aws_kms_key.alias_arn
  description = "Key ARN"
}

output "key_id" {
  value       = module.aws_kms_key.
  description = "Key ID"
}

output "alias_arn" {
  value       = join("", aws_kms_alias.default.*.arn)
  description = "Alias ARN"
}

output "alias_name" {
  value       = join("", aws_kms_alias.default.*.name)
  description = "Alias name"
}

output "kms_policy_json" {
  value = var.create ? data.aws_iam_policy_document.this.json : null
}
