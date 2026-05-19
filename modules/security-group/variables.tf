variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "allowed_http_cidr_blocks" {
  description = "CIDR blocks allowed to access ALB over HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_https_cidr_blocks" {
  description = "CIDR blocks allowed to access ALB over HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}