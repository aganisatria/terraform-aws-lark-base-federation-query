locals {
  create_lark_app_secret        = var.lark_app_secret_manager == ""
  create_athena_connector_role = var.lambda_athena_connector_role_arn == ""
  create_lark_base_crawler_role = var.lambda_lark_base_crawler_role_arn == ""
  use_kms_key                   = var.kms_key_id != ""

  common_tags = merge(var.tags, {
    StackName = var.stack_name
  })

  lark_secret_reference = module.lark_secret.created ? module.lark_secret.secret_arn : var.lark_app_secret_manager
  lark_secret_env_value = module.lark_secret.created ? module.lark_secret.secret_name : var.lark_app_secret_manager

  athena_connector_role_arn = local.create_athena_connector_role ? module.athena_connector_role[0].role_arn : var.lambda_athena_connector_role_arn
  lark_base_crawler_role_arn = local.create_lark_base_crawler_role ? module.crawler_lambda_role[0].role_arn : var.lambda_lark_base_crawler_role_arn

  lambda_assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  athena_connector_policy_doc = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.stack_name}-AthenaConnector:*"
      },
      {
        Effect = "Allow",
        Action = "secretsmanager:GetSecretValue",
        Resource = local.lark_secret_reference
      },
      {
        Effect = "Allow",
        Action = [
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetPartition",
          "glue:GetPartitions"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::${var.spill_bucket}",
          "arn:${data.aws_partition.current.partition}:s3:::${var.spill_bucket}/${var.spill_prefix}/*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = ["athena:GetQueryExecution"],
        Resource = "*"
      }
    ]
  })

  crawler_policy_doc = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.stack_name}-CrawlerFunction:*"
      },
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = local.lark_secret_reference
      },
      {
        Effect = "Allow",
        Action = [
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables",
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:CreateDatabase",
          "glue:UpdateDatabase",
          "glue:BatchCreatePartition",
          "glue:BatchUpdatePartition",
          "glue:DeleteTable",
          "glue:DeletePartition",
          "glue:BatchDeleteTable",
          "glue:BatchDeletePartition"
        ],
        Resource = "*"
      }
    ]
  })

  kms_policy_doc = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["kms:GenerateRandom"],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey*"
        ],
        Effect   = "Allow",
        Resource = "arn:${data.aws_partition.current.partition}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.kms_key_id}"
      }
    ]
  })

  kms_policy_attach_role_names = compact(concat(
      local.create_athena_connector_role ? [module.athena_connector_role[0].role_name] : [],
      local.create_lark_base_crawler_role ? [module.crawler_lambda_role[0].role_name] : []
  ))

  athena_connector_env_vars = {
    spill_bucket                             = var.spill_bucket
    spill_prefix                             = var.spill_prefix
    default_secret_manager_lark_app_key      = local.lark_secret_env_value
    default_page_size                        = var.lark_page_size
    default_does_activate_lark_base_source   = var.activate_lark_base_source
    default_does_activate_lark_drive_source  = var.activate_lark_drive_source
    default_does_activate_experimental_feature = var.activate_experimental_feature
    default_lark_base_sources                = var.lark_base_sources
    default_lark_drive_sources               = var.lark_drive_sources
    kms_key_id                               = local.use_kms_key ? var.kms_key_id : ""
    JAVA_TOOL_OPTIONS                        = "--add-opens=java.base/java.nio=ALL-UNNAMED"
    disable_spill_encryption                 = var.disable_spill_encryption
  }
  glue_crawler_env_vars = {
    default_secret_manager_lark_app_key = local.lark_secret_env_value
  }
}