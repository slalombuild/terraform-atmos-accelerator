output "acms" {
  description = "ACM certificates for domains"
  value       = { for k, v in module.acm : k => v.arn }
}

output "zones" {
  description = "DNS zones"
  value       = aws_route53_zone.root
}
