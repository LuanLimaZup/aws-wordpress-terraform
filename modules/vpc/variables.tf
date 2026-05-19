variable "cidr_block" {
  type        = string
  description = "CIDR block da VPC"
}

variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão do projeto"
}

variable "region" {
  type        = string
  description = "Região AWS usada para definir as AZs"
}