output "lambda_arn" {
  description = "ARN of the lambda function"
  value       = module.lambda_function.arn
}

output "invoke_arn" {
  description = "Inkoke ARN of the lambda function"
  value       = module.lambda_function.invoke_arn
}

output "function_name" {
  description = "Name of the lambda function"
  value       = module.lambda_function.function_name
}
