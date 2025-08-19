variable "deply_key" {
  description = "Enable deploy keys for repositories"
  type        = bool
  default     = false
}

variable "environments" {
  description = "List of environments to create repositories for"
  type        = set(string)
  default     = ["dev", "prod"]
}