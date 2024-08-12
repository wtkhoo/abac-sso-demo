# Variables
variable "name" {
  description = "Prefix name for resources"
  type        = string
  default     = "abac-demo"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "account_id" {
  description = "AWS account ID for SSO permission set mapping"
  type        = string
}

variable "user_list" {
  description = "List of user principal names for SSO permission set mapping"
  type        = list(string)
}