variable "create_secret" {
  description = "Flag to indicate whether to create the secret."
  type        = bool
}

variable "secret_name_prefix" {
  description = "Prefix for the secret name if created."
  type        = string
}

variable "secret_description" {
  description = "Description for the secret if created."
  type        = string
  default     = "Managed by Terraform"
}

variable "tags" {
  description = "Tags to apply to the secret."
  type        = map(string)
  default     = {}
}