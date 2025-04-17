resource "aws_iam_role" "this" {
  name                 = var.role_name
  assume_role_policy   = var.assume_role_policy_json
  permissions_boundary = var.permissions_boundary_arn
  managed_policy_arns  = var.managed_policy_arns
  tags                 = var.tags
}