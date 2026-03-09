output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.cae.id
  # value = data.azurerm_container_app_environment.cae.id
}

output "backend_container_app_name" {
  value = azurerm_container_app.backend.name
}

output "frontend_container_app_name" {
  value = azurerm_container_app.frontend.name
}

output "backend_fqdn" {
  value       = azurerm_container_app.backend.latest_revision_fqdn
  description = "URL interna del backend"
}

output "frontend_fqdn" {
  value       = azurerm_container_app.frontend.latest_revision_fqdn
  description = "URL pública del frontend"
}