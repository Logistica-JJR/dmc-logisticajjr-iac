variable "resource_group_name" {
  type = string
}

variable "container_env_id" {
  type = string
}

variable "sql_connection_string" {
  type      = string
  sensitive = true
}

variable "image" {
  description = "URL de la imagen del contenedor del backend"
  type        = string
}