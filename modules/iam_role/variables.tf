variable "role_name" {
  description = "Name for the IAM role."
  type        = string
}

variable "assume_role_policy_json" {
  description = "Assume role policy document in JSON format."
  type        = string
}

variable "permissions_boundary_arn" {
  description = "(Optional) ARN of the policy to use as a permissions boundary."
  type        = string
  default     = null
}


variable "tags" {
  description = "Tags to apply to the role."
  type        = map(string)
  default     = {}
}
