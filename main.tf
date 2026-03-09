terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.90"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
}

# -------------------------------
# Resource Group
# -------------------------------
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# -------------------------------
# Container App Environment
# -------------------------------
resource "azurerm_container_app_environment" "cae" {
  name                = var.cae_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
# data "azurerm_container_app_environment" "cae" {
  # name                = var.cae_name
  # resource_group_name = data.azurerm_resource_group.rg.name
# }


# -------------------------------
# Backend Container App
# -------------------------------
resource "azurerm_container_app" "backend" {
  name                         = var.backend_ca
  resource_group_name          = data.azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  # container_app_environment_id = data.azurerm_container_app_environment.cae.id
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = var.backend_image
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 5000

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

# -------------------------------
# Frontend Container App (público)
# -------------------------------
resource "azurerm_container_app" "frontend" {
  name                         = var.frontend_ca
  resource_group_name          = data.azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  # container_app_environment_id = data.azurerm_container_app_environment.cae.id
  revision_mode                = "Single"

  template {
    container {
      name   = "frontend"
      image  = var.frontend_image
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}