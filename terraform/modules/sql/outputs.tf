output "sql_server_name" {
  description = "Nombre del servidor Azure SQL"
  value       = azurerm_mssql_server.sql.name
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = azurerm_mssql_database.db.name
}

output "connection_string" {
  description = "Connection string para el backend"
  value       = "Server=tcp:${azurerm_mssql_server.sql.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.db.name};User ID=${var.sql_admin};Password=${var.sql_password};Encrypt=true;"
  sensitive   = true
}
