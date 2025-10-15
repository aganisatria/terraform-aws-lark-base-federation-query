# Terraform AWS Secrets Manager Module

This module creates a secret in AWS Secrets Manager.

## Usage

```hcl
module "secret_manager" {
  source = "./modules/secret_manager"

  create_secret        = true
  secret_name_prefix   = "my-app"
  secret_description   = "My App Secret"
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `create_secret` | Flag to indicate whether to create the secret. | `bool` | n/a | yes |
| `secret_name_prefix` | Prefix for the secret name if created. | `string` | n/a | yes |
| `secret_description` | Description for the secret if created. | `string` | `"Managed by Terraform"` | no |
| `tags` | Tags to apply to the secret. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `created` | Boolean indicating if the secret was created by this module. |
| `secret_arn` | ARN of the secret, if created. |
| `secret_name` | Name of the secret, if created. |
