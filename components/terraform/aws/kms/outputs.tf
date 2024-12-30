output "alias_arn" {
  description = "Alias ARN"
  value       = join("", aws_kms_alias.default[*].arn)
}

output "alias_name" {
  description = "Alias name"
  value       = join("", aws_kms_alias.default[*].name)
}

output "key_arn" {
  description = "Key ARN"
  value       = join("", aws_kms_key.default[*].arn)
}

output "key_id" {
  description = "Key ID"
  value       = join("", aws_kms_key.default[*].key_id)
}
