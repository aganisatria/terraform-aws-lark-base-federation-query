# Terraform AWS Athena Data Catalog Module

This module creates an AWS Athena Data Catalog.

## Usage

```hcl
module "athena_catalog" {
  source = "./modules/athena_data_catalog"

  catalog_name        = "my-athena-catalog"
  description         = "My Athena Data Catalog"
  lambda_function_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `catalog_name` | Name for the Athena Data Catalog. | `string` | n/a | yes |
| `description` | (Optional) Description for the Athena Data Catalog. | `string` | `"Managed by Terraform"` | no |
| `lambda_function_arn` | ARN of the Lambda function to use for the catalog. | `string` | n/a | yes |
| `tags` | Tags to apply to the data catalog. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `catalog_name` | Name of the created Athena Data Catalog. |
