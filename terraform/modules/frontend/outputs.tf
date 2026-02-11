output "frontend_fqdn" {
  description = "FQDN público del frontend Container App"
  value       = azurerm_container_app.frontend.ingress[0].fqdn
}
