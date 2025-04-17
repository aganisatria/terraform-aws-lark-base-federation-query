resource "aws_secretsmanager_secret" "this" {
  count = var.create_secret ? 1 : 0

  name        = "${var.secret_name_prefix}-LarkAppSecret"
  description = var.secret_description
  tags        = var.tags
}