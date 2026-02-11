output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "frontend_url" {
  description = "URL pública del frontend"
  value       = module.frontend.frontend_fqdn
}

output "backend_internal_name" {
  description = "Nombre interno del backend dentro del Container App Environment"
  value       = module.backend.backend_name
}

output "sql_server_name" {
  description = "Nombre del servidor Azure SQL"
  value       = module.sql.sql_server_name
}

output "sql_database_name" {
  description = "Nombre de la base de datos"
  value       = module.sql.database_name
}

output "sql_connection_string" {
  description = "Connection string para el backend"
  value       = module.sql.connection_string
  sensitive   = true
}
