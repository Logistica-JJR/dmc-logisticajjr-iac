resource "azurerm_mssql_server" "sql" {
  name                         = "sql-demo-server123"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_password
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "db" {
  name      = "appdb"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "sql-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_subnet_id

  private_service_connection {
    name                           = "sql-connection"
    private_connection_resource_id = azurerm_mssql_server.sql.id
	is_manual_connection           = false   # 🔹 OBLIGATORIO
    subresource_names              = ["sqlServer"]
  }
}
