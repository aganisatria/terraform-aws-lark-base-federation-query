# Terraform AWS Lambda Athena Connector Module

This module creates an AWS Lambda function for the Athena Connector.

## Usage

```hcl
module "athena_connector" {
  source = "./modules/lambda/athena_connector"

  function_name        = "my-athena-connector"
  description          = "My Athena Connector"
  role_arn             = "arn:aws:iam::123456789012:role/my-role"
  s3_bucket            = "my-lambda-bucket"
  s3_key               = "path/to/my/lambda.zip"
  handler              = "com.mycompany.MyHandler"
  runtime              = "java17"
  memory_size          = 512
  timeout              = 30
  environment_variables = {
    "VAR1" = "value1"
  }
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `function_name` | The name of the Lambda function. | `string` | n/a | yes |
| `description` | The description of the Lambda function. | `string` | n/a | yes |
| `role_arn` | The ARN of the IAM role for the Lambda function. | `string` | n/a | yes |
| `s3_bucket` | The S3 bucket containing the Lambda function code. | `string` | n/a | yes |
| `s3_key` | The S3 key for the Lambda function code. | `string` | n/a | yes |
| `handler` | The Lambda function handler. | `string` | n/a | yes |
| `runtime` | The Lambda function runtime. | `string` | n/a | yes |
| `memory_size` | The memory size for the Lambda function. | `number` | n/a | yes |
| `timeout` | The timeout for the Lambda function. | `number` | n/a | yes |
| `environment_variables` | The environment variables for the Lambda function. | `map(string)` | n/a | yes |
| `tags` | The tags for the Lambda function. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `lambda_name` | The name of the Lambda function. |
| `lambda_arn` | The ARN of the Lambda function. |
