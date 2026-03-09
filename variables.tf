variable "rg_name" {
  type    = string
  default = "rg-cicd-terraform-app-logisticaJJR"
}

variable "location" {
  type    = string
  default = "westus2"
}

variable "cae_name" {
  type    = string
  default = "cae-ljjr"
}

variable "backend_ca" {
  type    = string
  default = "ca-be-ljjr"
}

variable "frontend_ca" {
  type    = string
  default = "ca-fe-ljjr"
}

variable "backend_image" {
  type    = string
  default = "ricvera792/dmc-logisticajjr-backend:latest"
}

variable "frontend_image" {
  type    = string
  default = "ricvera792/dmc-logisticajjr-frontend:latest"
}