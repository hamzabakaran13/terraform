variable "project" {
  description = "Project name"
  type        = string
  default = "frontend"
  validation {
    condition     = contains(["frontend", "infrastructure", "backend"], var.project)
    error_message = "Project must be one of: frontend, infrastructure, backend."
  }
}

variable "env" {
  description = "Environment"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Env must be dev or prod."
  }
}


variable "repos" {
  type = map(object({
    lang      = string
    filename  = string
    pages     = bool
    auto_init = optional(bool, true)
    visibility = string
  }))
  description = "Repositories"
}

  
variable "repo_max" {
  description = "Maximum number of repositories"
  type        = number
  default     = 2
  validation {
    condition     = var.repo_max > 0 && var.repo_max <= 10
    error_message = "repo_max must be between 1 and 10."
  }
  
}