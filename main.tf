module "lark_secret" {
  source = "./modules/secretManager"
  count  = 1

  create_secret       = local.create_lark_app_secret
  secret_name_prefix  = var.stack_name
  secret_description  = "Secret containing the Lark Application ID and Secret for ${var.stack_name}."
  tags                = local.common_tags
}

module "athena_connector_role" {
  source = "./modules/iam_role"
  count  = local.create_athena_connector_role ? 1 : 0

  role_name                 = "${var.stack_name}-AthenaConnectorRole"
  assume_role_policy_json   = local.lambda_assume_role_policy
  permissions_boundary_arn  = var.permissions_boundary_arn_lambda_athena_connector != "" ? var.permissions_boundary_arn_lambda_athena_connector : null
  tags                      = local.common_tags
}

module "crawler_lambda_role" {
  source = "./modules/iam_role"
  count  = local.create_lark_base_crawler_role ? 1 : 0

  role_name                 = "${var.stack_name}-CrawlerLambdaRole"
  assume_role_policy_json   = local.lambda_assume_role_policy
  permissions_boundary_arn  = var.permissions_boundary_arn_lambda_lark_base_crawler != "" ? var.permissions_boundary_arn_lambda_lark_base_crawler : null
  tags                      = local.common_tags
}

module "athena_connector_policy" {
  source = "./modules/iam_policy"
  count  = local.create_athena_connector_role ? 1 : 0

  policy_name          = "${var.stack_name}-AthenaConnectorAccess"
  description          = "Permissions for the Athena Connector Lambda"
  policy_document_json = local.athena_connector_policy_doc
  attach_to_roles      = [module.athena_connector_role[0].role_name]
  tags                 = local.common_tags
}

module "crawler_lambda_policy" {
  source = "./modules/iam_policy"
  count  = local.create_lark_base_crawler_role ? 1 : 0

  policy_name          = "${var.stack_name}-CrawlerLambdaAccess"
  description          = "Permissions for the Glue Crawler Lambda"
  policy_document_json = local.crawler_policy_doc
  attach_to_roles      = [module.crawler_lambda_role[0].role_name]
  tags                 = local.common_tags
}

module "kms_policy" {
  source = "./modules/iam_policy"
  count  = local.use_kms_key ? 1 : 0

  policy_name          = "${var.stack_name}-FunctionKMSPolicy"
  description          = "Policy to allow Lambda functions to use the specified KMS key."
  policy_document_json = local.kms_policy_doc
  attach_to_roles      = local.kms_policy_attach_role_names
  tags                 = local.common_tags
}

module "athena_connector_lambda" {
  source = "./modules/lambda/athena_connector"

  function_name        = "${var.stack_name}-AthenaConnector"
  description          = "Athena Connector for Lark Base (${var.stack_name})"
  role_arn             = local.athena_connector_role_arn # Use determined ARN
  s3_bucket            = var.connector_code_s3_bucket
  s3_key               = var.connector_code_s3_key
  handler              = "com.amazonaws.athena.connectors.lark.base.BaseCompositeHandler"
  runtime              = "java17"
  memory_size          = var.lambda_memory
  timeout              = var.lambda_timeout
  environment_variables = local.athena_connector_env_vars
  tags                 = local.common_tags

  depends_on = [
    module.athena_connector_role,
    module.athena_connector_policy,
    module.kms_policy
  ]
}

module "glue_crawler_lambda" {
  source = "./modules/lambda/glue_crawler"

  function_name        = "${var.stack_name}-CrawlerFunction"
  description          = "Glue Crawler for Lark Base (${var.stack_name})"
  role_arn             = local.lark_base_crawler_role_arn # Use determined ARN
  s3_bucket            = var.crawler_code_s3_bucket
  s3_key               = var.crawler_code_s3_key
  handler              = "com.amazonaws.glue.lark.base.crawler.MainLarkBaseCrawlerHandler"
  runtime              = "java17"
  memory_size          = var.lambda_memory
  timeout              = var.lambda_timeout
  environment_variables = local.glue_crawler_env_vars
  tags                 = local.common_tags

  depends_on = [
    module.crawler_lambda_role,
    module.crawler_lambda_policy,
    module.kms_policy
  ]
}

module "athena_catalog" {
  source = "./modules/athena_data_catalog"

  catalog_name        = module.athena_connector_lambda.lambda_name
  description         = "Athena Data Catalog for Lark Base Connector (${module.athena_connector_lambda.lambda_name})"
  lambda_function_arn = module.athena_connector_lambda.lambda_arn
  tags                = local.common_tags

  depends_on = [module.athena_connector_lambda]
}