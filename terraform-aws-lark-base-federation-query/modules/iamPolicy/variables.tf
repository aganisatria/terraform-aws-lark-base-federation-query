variable "policy_name" {
  description = "Name for the IAM policy."
  type        = string
}

variable "description" {
  description = "(Optional) Description for the IAM policy."
  type        = string
  default     = "Managed by Terraform"
}

variable "policy_document_json" {
  description = "IAM policy document in JSON format."
  type        = string
}

variable "attach_to_roles" {
  description = "(Optional) List of IAM role names to attach this policy to."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the policy."
  type        = map(string)
  default     = {}
}