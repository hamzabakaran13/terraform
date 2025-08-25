variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string 
  }

variable "num_subnets" {
  description = "Number of subnets to create"
  type        = number
  default     = 1
}  