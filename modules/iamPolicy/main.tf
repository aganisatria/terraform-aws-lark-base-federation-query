resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.description
  policy      = var.policy_document_json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.attach_to_roles)

  role       = each.key
  policy_arn = aws_iam_policy.this.arn
}