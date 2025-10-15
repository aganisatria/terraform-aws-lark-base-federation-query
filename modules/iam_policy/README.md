# Terraform AWS IAM Policy Module

This module creates an AWS IAM Policy and attaches it to specified roles.

## Usage

```hcl
module "iam_policy" {
  source = "./modules/iam_policy"

  policy_name          = "my-iam-policy"
  description          = "My IAM Policy"
  policy_document_json = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"*\",\"Resource\":\"*\"}]}"
  attach_to_roles      = ["my-role-1", "my-role-2"]
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| `policy_name` | Name for the IAM policy. | `string` | n/a | yes |
| `description` | (Optional) Description for the IAM policy. | `string` | `"Managed by Terraform"` | no |
| `policy_document_json` | IAM policy document in JSON format. | `string` | n/a | yes |
| `attach_to_roles` | (Optional) List of IAM role names to attach this policy to. | `list(string)` | `[]` | no |
| `tags` | Tags to apply to the policy. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `policy_arn` | ARN of the created IAM policy. |
| `policy_name` | Name of the created IAM policy. |
