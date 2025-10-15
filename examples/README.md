# Lark Base Federation Query Terraform Module Example

This example demonstrates how to use the Lark Base Federation Query Terraform module to deploy the necessary AWS resources for querying Lark Base data with Amazon Athena.

## Prerequisites

- Terraform v1.0 or later
- An AWS account with the necessary permissions

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/aganisatria/terraform-aws-lark-base-federation-query
   cd terraform-aws-lark-base-federation-query/examples
   ```

2. **Create a `terraform.tfvars` file:**

   Create a `terraform.tfvars` file in the `examples` directory and provide values for the required variables. For example:

   ```hcl
   spill_bucket               = "your-athena-spill-bucket"
   connector_code_s3_bucket = "your-connector-code-bucket"
   connector_code_s3_key    = "path/to/connector.jar"
   crawler_code_s3_bucket   = "your-crawler-code-bucket"
   crawler_code_s3_key      = "path/to/crawler.jar"
   ```

3. **Initialize Terraform:**

   ```bash
   terraform init
   ```

4. **Plan the deployment:**

   ```bash
   terraform plan
   ```

5. **Apply the configuration:**

   ```bash
   terraform apply
   ```

## Inputs

| Name                       | Description                                          | Type         | Default                        |
| -------------------------- | ---------------------------------------------------- | ------------ | ------------------------------ |
| `aws_region`               | AWS region to deploy the stack.                      | `string`     | `"us-east-1"`                  |
| `stack_name`               | Name of the stack.                                   | `string`     | `"lark-base-federation-query"` |
| `spill_bucket`             | Name of the S3 bucket for Athena query spillage.     | `string`     | n/a                            |
| `spill_prefix`             | Prefix for Athena query spillage in the S3 bucket.   | `string`     | `"athena-spill"`               |
| `connector_code_s3_bucket` | S3 bucket containing the Athena connector code.      | `string`     | n/a                            |
| `connector_code_s3_key`    | S3 key for the Athena connector code.                | `string`     | n/a                            |
| `crawler_code_s3_bucket`   | S3 bucket containing the Glue crawler code.          | `string`     | n/a                            |
| `crawler_code_s3_key`      | S3 key for the Glue crawler code.                    | `string`     | n/a                            |
| `tags`                     | A map of tags to assign to the resources.            | `map(string)`| `{}`                           |

## Outputs

| Name                        | Description                                                              |
| --------------------------- | ------------------------------------------------------------------------ |
| `athena_catalog_name`       | Name of the Athena Data Catalog                                          |
| `connector_lambda_arn`      | ARN of the Athena Connector Lambda function                              |
| `crawler_lambda_arn`        | ARN of the Glue Crawler Lambda function                                  |
| `connector_role_arn`        | ARN of the IAM Role for the Athena Connector Lambda                      |
| `crawler_lambda_role_arn`   | ARN of the IAM Role for the Glue Crawler Lambda                          |
| `lark_app_secret_arn`       | ARN of the Lark Application ID secret (if created)                       |
| `kms_policy_arn`            | ARN of the KMS policy for the Lambda functions (if created)              |
| `athena_connector_policy_arn` | ARN of the inline policy for the Athena Connector Lambda (if created)    |
| `crawler_lambda_policy_arn` | ARN of the inline policy for the Crawler Lambda (if created)             |
