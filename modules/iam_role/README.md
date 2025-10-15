# Terraform AWS IAM Role Module

This module creates an AWS IAM Role.

## Usage

```hcl
module "iam_role" {
  source = "./modules/iam_role"

  role_name                 = "my-iam-role"
  assume_role_policy_json   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  permissions_boundary_arn  = "arn:aws:iam::123456789012:policy/my-permissions-boundary"
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `role_name` | Name for the IAM role. | `string` | n/a | yes |
| `assume_role_policy_json` | Assume role policy document in JSON format. | `string` | n/a | yes |
| `permissions_boundary_arn` | (Optional) ARN of the policy to use as a permissions boundary. | `string` | `null` | no |
| `tags` | Tags to apply to the role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `role_arn` | ARN of the created IAM role. |
| `role_name` | Name of the created IAM role. |
