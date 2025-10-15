module "lark_base_federation_query" {
  source = "../"

  stack_name = var.stack_name

  spill_bucket = var.spill_bucket
  spill_prefix = var.spill_prefix

  connector_code_s3_bucket = var.connector_code_s3_bucket
  connector_code_s3_key    = var.connector_code_s3_key

  crawler_code_s3_bucket = var.crawler_code_s3_bucket
  crawler_code_s3_key    = var.crawler_code_s3_key

  tags = var.tags
}

