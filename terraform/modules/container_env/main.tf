resource "azurerm_container_app_environment" "env" {
  name                     = "aca-env"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  infrastructure_subnet_id = var.subnet_id
}
