resource "aws_athena_data_catalog" "this" {
  name        = var.catalog_name
  description = var.description
  type        = "LAMBDA"
  parameters = {
    function = var.lambda_function_arn
  }
  tags = var.tags
}