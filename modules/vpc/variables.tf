variable "cidr_block" {
  type        = string
  description = "CIDR block da VPC"
}

variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
}

variable "region" {
  type        = string
  description = "Região AWS usada para definir as AZs"
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão do projeto"
}