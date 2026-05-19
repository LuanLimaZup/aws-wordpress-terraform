variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o ALB será criado"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "IDs das subnets públicas para o ALB"
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão do projeto"
}

variable "alb_security_group_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}