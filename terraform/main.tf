resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

module "container_env" {
  source              = "./modules/container_env"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.aca_subnet_id
}

module "sql" {
  source              = "./modules/sql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_id             = module.network.vnet_id
  sql_admin           = var.sql_admin
  sql_password        = var.sql_password
  private_subnet_id   = module.network.private_subnet_id
}

module "backend" {
  source                     = "./modules/backend"
  resource_group_name        = azurerm_resource_group.rg.name
  container_env_id           = module.container_env.env_id
  sql_connection_string      = module.sql.connection_string
  image                      = "myregistry.azurecr.io/backend:latest"   # <- aquí
}

module "frontend" {
  source                     = "./modules/frontend"
  resource_group_name        = azurerm_resource_group.rg.name
  container_env_id           = module.container_env.env_id
}
