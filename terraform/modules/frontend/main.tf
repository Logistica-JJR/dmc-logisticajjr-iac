resource "azurerm_container_app" "frontend" {
  name                         = "frontend-app"
  container_app_environment_id = var.container_env_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "frontend"
      image  = "myregistry.azurecr.io/frontend:latest"
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "BACKEND_URL"
        value = "http://backend-app"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"

    traffic_weight {
      latest_revision = true  # 🔹 usa esto en lugar de revision_name
      percentage      = 100   # 🔹 todo el tráfico va a la última revisión
    }
 }
}
