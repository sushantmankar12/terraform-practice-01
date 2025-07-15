variable "subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "db_username" {
  description = ""
  type        = string
}

variable "db_password" {
  description = ""
  type        = string
  sensitive   = true
}
