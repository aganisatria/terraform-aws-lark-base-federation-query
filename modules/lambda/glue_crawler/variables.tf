variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "description" {
  description = "The description of the Lambda function."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function."
  type        = string
}

variable "s3_bucket" {
  description = "The S3 bucket containing the Lambda function code."
  type        = string
}

variable "s3_key" {
  description = "The S3 key for the Lambda function code."
  type        = string
}

variable "handler" {
  description = "The Lambda function handler."
  type        = string
}

variable "runtime" {
  description = "The Lambda function runtime."
  type        = string
}

variable "memory_size" {
  description = "The memory size for the Lambda function."
  type        = number
}

variable "timeout" {
  description = "The timeout for the Lambda function."
  type        = number
}

variable "environment_variables" {
  description = "The environment variables for the Lambda function."
  type        = map(string)
}

variable "tags" {
  description = "The tags for the Lambda function."
  type        = map(string)
}
