output "created" {
  description = "Boolean indicating if the secret was created by this module."
  value       = var.create_secret
}

output "secret_arn" {
  description = "ARN of the secret, if created."
  value       = length(aws_secretsmanager_secret.this) > 0 ? aws_secretsmanager_secret.this[0].arn : null
}

output "secret_name" {
  description = "Name of the secret, if created."
  value       = length(aws_secretsmanager_secret.this) > 0 ? aws_secretsmanager_secret.this[0].name : null
}