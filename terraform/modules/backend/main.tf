resource "azurerm_container_app" "backend" {
  name                         = "backend-app"
  container_app_environment_id = var.container_env_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = var.image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "DB_CONNECTION"
        value = var.sql_connection_string
      }
    }
  }

  ingress {
    external_enabled = false
    target_port      = 8080
    transport        = "auto"

    # 🔹 BLOQUE OBLIGATORIO
    traffic_weight {
      latest_revision = true  # 🔹 usa esto en lugar de revision_name
      percentage    = 100 # 🔹 obligatorio ahora
    }
  }
}
