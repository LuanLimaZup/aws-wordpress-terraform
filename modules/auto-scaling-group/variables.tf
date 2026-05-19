variable "launch_template_id" {
  type        = string
  description = "Launch template ID used by the Auto Scaling Group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs where EC2 instances will run"
}

variable "target_group_arn" {
  type        = string
  description = "ALB target group ARN"
}

variable "desired_capacity" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to ASG instances"
}