variable "stack_name" {
  description = "A unique name for the stack resources (used for naming)."
  type        = string
}

variable "spill_bucket" {
  description = "S3 bucket name for Athena query spilling. Connector Lambda needs read/write access."
  type        = string
}

variable "spill_prefix" {
  description = "S3 prefix for Athena query spilling."
  type        = string
  default     = "athena-spill"
}

variable "connector_code_s3_bucket" {
  description = "S3 bucket containing the Athena connector JAR file."
  type        = string
}

variable "connector_code_s3_key" {
  description = "S3 key (path) to the Athena connector JAR file."
  type        = string
}

variable "crawler_code_s3_bucket" {
  description = "S3 bucket containing the Glue crawler JAR file."
  type        = string
}

variable "crawler_code_s3_key" {
  description = "S3 key (path) to the Glue crawler JAR file."
  type        = string
}

variable "lark_page_size" {
  description = "Page size for Lark API calls from connector."
  type        = number
  default     = 500
}

variable "activate_lark_base_source" {
  description = "Activate direct Lark Base table discovery via environment mapping in connector."
  type        = string
  default     = "false"
  validation {
    condition     = contains(["true", "false"], var.activate_lark_base_source)
    error_message = "Allowed values are 'true' or 'false'."
  }
}

variable "lark_base_sources" {
  description = "Lark Base sources to be activated in the connector. Format: \"larkBaseId1:larkBaseTableId1,larkBaseId2:larkBaseTableId2\""
  type        = string
  default     = ""
}

variable "activate_lark_drive_source" {
  description = "Activate Lark Drive source in connector (if implemented)."
  type        = string
  default     = "false"
  # validation {
  #   condition     = contains(["true", "false"], var.activate_lark_drive_source)
  #   error_message = "Allowed values are 'true' or 'false'."
  # }
}

variable "lark_drive_sources" {
  description = "Lark Drive sources to be activated in the connector. Format: \"larkDrivePageToken1,larkDrivePageToken2\""
  type        = string
  default     = ""
}

variable "activate_experimental_feature" {
  description = "Activate experimental features in connector."
  type        = string
  default     = "false"
  # validation {
  #   condition     = contains(["true", "false"], var.activate_experimental_feature)
  #   error_message = "Allowed values are 'true' or 'false'."
  # }
}

variable "lambda_timeout" {
  description = "Maximum Lambda invocation runtime in seconds. (min 1 - 900 max)"
  type        = number
  default     = 900
}

variable "lambda_memory" {
  description = "Lambda memory in MB (min 128 - 3008 max)."
  type        = number
  default     = 3008
}

variable "lambda_athena_connector_role_arn" {
  description = "(Optional) A custom role ARN to be used by the Athena Connector lambda. If empty, a new role is created."
  type        = string
  default     = ""
}

variable "lambda_lark_base_crawler_role_arn" {
  description = "(Optional) A custom role ARN to be used by the Lark Base Crawler lambda. If empty, a new role is created."
  type        = string
  default     = ""
}

variable "disable_spill_encryption" {
  description = "WARNING: If set to 'true' encryption for spilled data is disabled."
  type        = string
  default     = "false"
  # validation {
  #   condition     = contains(["true", "false"], var.disable_spill_encryption)
  #   error_message = "Allowed values are 'true' or 'false'."
  # }
}

variable "kms_key_id" {
  description = "(Optional) KMS Key ID for spill encryption. If empty, AES-GCM with a random key is used."
  type        = string
  default     = ""
}

variable "permissions_boundary_arn_lambda_athena_connector" {
  description = "(Optional) An IAM policy ARN to use as the PermissionsBoundary for the created Lambda Athena Connector role."
  type        = string
  default     = ""
}

variable "permissions_boundary_arn_lambda_lark_base_crawler" {
  description = "(Optional) An IAM policy ARN to use as the PermissionsBoundary for the created Lambda Lark Base Crawler role."
  type        = string
  default     = ""
}

variable "lark_app_secret_manager" {
  description = "(Optional) The Name or ARN of the Lark Application ID secret in Secrets Manager. If empty, a new secret will be created."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Optional tags to apply to created resources."
  type        = map(string)
  default     = {}
}