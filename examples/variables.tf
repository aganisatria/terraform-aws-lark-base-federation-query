variable "stack_name" {
  description = "Name of the stack."
  type        = string
}

variable "spill_bucket" {
  description = "Name of the S3 bucket for Athena query spillage."
  type        = string
}

variable "spill_prefix" {
  description = "Prefix for Athena query spillage in the S3 bucket."
  type        = string
}

variable "connector_code_s3_bucket" {
  description = "S3 bucket containing the Athena connector code."
  type        = string
}

variable "connector_code_s3_key" {
  description = "S3 key for the Athena connector code."
  type        = string
}

variable "crawler_code_s3_bucket" {
  description = "S3 bucket containing the Glue crawler code."
  type        = string
}

variable "crawler_code_s3_key" {
  description = "S3 key for the Glue crawler code."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "lark-base-federation-query"
  }
}
