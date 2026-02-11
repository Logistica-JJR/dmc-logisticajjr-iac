output "backend_name" {
  description = "Nombre del Container App del backend"
  value       = azurerm_container_app.backend.name
}