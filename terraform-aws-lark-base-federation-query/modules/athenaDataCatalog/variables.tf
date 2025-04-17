variable "catalog_name" {
  description = "Name for the Athena Data Catalog."
  type        = string
}

variable "description" {
  description = "(Optional) Description for the Athena Data Catalog."
  type        = string
  default     = "Managed by Terraform"
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to use for the catalog."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the data catalog."
  type        = map(string)
  default     = {}
}