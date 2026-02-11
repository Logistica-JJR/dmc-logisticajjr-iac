variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "sql_admin" {
  type = string
}

variable "sql_password" {
  type      = string
  sensitive = true
}
