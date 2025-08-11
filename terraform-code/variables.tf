variable "project" {
  type        = string
  description = "The project name for the repository."
  default     = "infrastructure"
}

variable "env" {
  type        = string
  description = "The environment for the repository."
  default     = "dev"
}

variable "auto_init" {
  type        = bool
  description = "Whether to automatically initialize the repository with a README."
}

variable "gitignore_template" {
  type        = string
  description = "The gitignore template to use."
  default     = "Terraform"
}