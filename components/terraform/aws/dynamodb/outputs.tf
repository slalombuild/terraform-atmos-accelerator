output "global_secondary_index_names" {
  description = "DynamoDB global secondary index names"
  value       = module.dynamodb_table.global_secondary_index_names
}

output "local_secondary_index_names" {
  description = "DynamoDB local secondary index names"
  value       = module.dynamodb_table.local_secondary_index_names
}

output "table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb_table.table_arn
}

output "table_id" {
  description = "DynamoDB table ID"
  value       = module.dynamodb_table.table_id
}

output "table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb_table.table_name
}

output "table_stream_arn" {
  description = "DynamoDB table stream ARN"
  value       = module.dynamodb_table.table_stream_arn
}

output "table_stream_label" {
  description = "DynamoDB table stream label"
  value       = module.dynamodb_table.table_stream_label
}
