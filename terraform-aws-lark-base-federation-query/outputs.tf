output "athena_catalog_name" {
  description = "Name of the Athena Data Catalog"
  value       = module.athena_catalog.catalog_name
}

output "connector_lambda_arn" {
  description = "ARN of the Athena Connector Lambda function"
  value       = module.athena_connector_lambda.lambda_arn
}

output "crawler_lambda_arn" {
  description = "ARN of the Glue Crawler Lambda function"
  value       = module.glue_crawler_lambda.lambda_arn
}

output "connector_role_arn" {
  description = "ARN of the IAM Role for the Athena Connector Lambda"
  value       = local.athena_connector_role_arn
}

output "crawler_lambda_role_arn" {
  description = "ARN of the IAM Role for the Glue Crawler Lambda"
  value       = local.lark_base_crawler_role_arn
}

output "lark_app_secret_arn" {
  description = "ARN of the Lark Application ID secret (only if created by this deployment)"
  value       = module.lark_secret.created ? module.lark_secret.secret_arn : null
}

output "kms_policy_arn" {
  description = "ARN of the KMS policy for the Lambda functions (only if created by this deployment)"
  value       = length(module.kms_policy) > 0 ? module.kms_policy[0].policy_arn : null
}

output "athena_connector_policy_arn" {
  description = "ARN of the inline policy for the Athena Connector Lambda (only if created)"
  value       = length(module.athena_connector_policy) > 0 ? module.athena_connector_policy[0].policy_arn : null
}

output "crawler_lambda_policy_arn" {
  description = "ARN of the inline policy for the Crawler Lambda (only if created)"
  value       = length(module.crawler_lambda_policy) > 0 ? module.crawler_lambda_policy[0].policy_arn : null
}