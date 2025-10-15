output "athena_catalog_name" {
  description = "Name of the Athena Data Catalog"
  value       = module.lark_base_federation_query.athena_catalog_name
}

output "connector_lambda_arn" {
  description = "ARN of the Athena Connector Lambda function"
  value       = module.lark_base_federation_query.connector_lambda_arn
}

output "crawler_lambda_arn" {
  description = "ARN of the Glue Crawler Lambda function"
  value       = module.lark_base_federation_query.crawler_lambda_arn
}

output "connector_role_arn" {
  description = "ARN of the IAM Role for the Athena Connector Lambda"
  value       = module.lark_base_federation_query.connector_role_arn
}

output "crawler_lambda_role_arn" {
  description = "ARN of the IAM Role for the Glue Crawler Lambda"
  value       = module.lark_base_federation_query.crawler_lambda_role_arn
}

output "lark_app_secret_arn" {
  description = "ARN of the Lark Application ID secret (only if created by this deployment)"
  value       = module.lark_base_federation_query.lark_app_secret_arn
}

output "kms_policy_arn" {
  description = "ARN of the KMS policy for the Lambda functions (only if created by this deployment)"
  value       = module.lark_base_federation_query.kms_policy_arn
}

output "athena_connector_policy_arn" {
  description = "ARN of the inline policy for the Athena Connector Lambda (only if created)"
  value       = module.lark_base_federation_query.athena_connector_policy_arn
}

output "crawler_lambda_policy_arn" {
  description = "ARN of the inline policy for the Crawler Lambda (only if created)"
  value       = module.lark_base_federation_query.crawler_lambda_policy_arn
}
