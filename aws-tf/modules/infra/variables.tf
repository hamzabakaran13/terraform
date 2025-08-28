variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "num_subnets" {
  description = "Number of subnets to create"
  type        = number
  default     = 1
}
variable "allowed_ips" {
  description = "CIDR blocks allowed to access the ALB"
  type        = set(string)
}