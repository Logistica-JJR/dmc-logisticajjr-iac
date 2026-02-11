variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-aca-demo"
}

variable "sql_admin" {
  description = "Administrador de Azure SQL"
  type        = string
}

variable "sql_password" {
  description = "Password del administrador SQL"
  type        = string
  sensitive   = true
}
