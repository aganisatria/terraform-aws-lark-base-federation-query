# Terraform AWS Lark Base Federation Query Module

This Terraform module deploys the necessary AWS resources for setting up an Athena query federation to Lark Base.

## Usage

```hcl
module "lark_federation" {
  source = "./path/to/this/module"

  stack_name                      = "my-lark-federation-stack"
  spill_bucket                    = "my-athena-spill-bucket"
  connector_code_s3_bucket        = "my-connector-bucket"
  connector_code_s3_key           = "path/to/connector.jar"
  crawler_code_s3_bucket          = "my-crawler-bucket"
  crawler_code_s3_key             = "path/to/crawler.jar"

  # Add other variables as needed
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `stack_name` | A unique name for the stack resources (used for naming). | `string` | n/a |
| `spill_bucket` | S3 bucket name for Athena query spilling. Connector Lambda needs read/write access. | `string` | n/a |
| `spill_prefix` | S3 prefix for Athena query spilling. | `string` | `"athena-spill"` |
| `connector_code_s3_bucket` | S3 bucket containing the Athena connector JAR file. | `string` | n/a |
| `connector_code_s3_key` | S3 key (path) to the Athena connector JAR file. | `string` | n/a |
| `crawler_code_s3_bucket` | S3 bucket containing the Glue crawler JAR file. | `string` | n/a |
| `crawler_code_s3_key` | S3 key (path) to the Glue crawler JAR file. | `string` | n/a |
| `lark_page_size` | Page size for Lark API calls from connector. | `number` | `500` |
| `activate_lark_base_source` | Activate direct Lark Base table discovery via environment mapping in connector. | `string` | `"false"` |
| `lark_base_sources` | Lark Base sources to be activated in the connector. Format: "larkBaseId1:larkBaseTableId1,larkBaseId2:larkBaseTableId2" | `string` | `""` |
| `activate_lark_drive_source` | Activate Lark Drive source in connector (if implemented). | `string` | `"false"` |
| `lark_drive_sources` | Lark Drive sources to be activated in the connector. Format: "larkDrivePageToken1,larkDrivePageToken2" | `string` | `""` |
| `activate_experimental_feature` | Activate experimental features in connector. | `string` | `"false"` |
| `lambda_timeout` | Maximum Lambda invocation runtime in seconds. (min 1 - 900 max) | `number` | `900` |
| `lambda_memory` | Lambda memory in MB (min 128 - 3008 max). | `number` | `3008` |
| `lambda_athena_connector_role_arn` | (Optional) A custom role ARN to be used by the Athena Connector lambda. If empty, a new role is created. | `string` | `""` |
| `lambda_lark_base_crawler_role_arn` | (Optional) A custom role ARN to be used by the Lark Base Crawler lambda. If empty, a new role is created. | `string` | `""` |
| `disable_spill_encryption` | WARNING: If set to 'true' encryption for spilled data is disabled. | `string` | `"false"` |
| `kms_key_id` | (Optional) KMS Key ID for spill encryption. If empty, AES-GCM with a random key is used. | `string` | `""` |
| `permissions_boundary_arn_lambda_athena_connector` | (Optional) An IAM policy ARN to use as the PermissionsBoundary for the created Lambda Athena Connector role. | `string` | `""` |
| `permissions_boundary_arn_lambda_lark_base_crawler` | (Optional) An IAM policy ARN to use as the PermissionsBoundary for the created Lambda Lark Base Crawler role. | `string` | `""` |
| `lark_app_secret_manager` | (Optional) The Name or ARN of the Lark Application ID secret in Secrets Manager. If empty, a new secret will be created. | `string` | `""` |
| `tags` | Optional tags to apply to created resources. | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `athena_catalog_name` | Name of the Athena Data Catalog |
| `connector_lambda_arn` | ARN of the Athena Connector Lambda function |
| `crawler_lambda_arn` | ARN of the Glue Crawler Lambda function |
| `connector_role_arn` | ARN of the IAM Role for the Athena Connector Lambda |
| `crawler_lambda_role_arn` | ARN of the IAM Role for the Glue Crawler Lambda |
| `lark_app_secret_arn` | ARN of the Lark Application ID secret (only if created by this deployment) |
| `kms_policy_arn` | ARN of the KMS policy for the Lambda functions (only if created by this deployment) |
| `athena_connector_policy_arn` | ARN of the inline policy for the Athena Connector Lambda (only if created) |
| `crawler_lambda_policy_arn` | ARN of the inline policy for the Crawler Lambda (only if created) |
