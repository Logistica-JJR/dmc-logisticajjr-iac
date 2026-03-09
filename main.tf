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
# Virtual Network
# -------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "backend" {
  name                 = var.backend_subnet
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "ca-backend-delegation"

    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_subnet" "frontend" {
  name                 = var.frontend_subnet
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "ca-frontend-delegation"

    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

# -------------------------------
# Container App Environment
# -------------------------------
# resource "azurerm_container_app_environment" "cae" {
  # name                = var.cae_name
  # resource_group_name = data.azurerm_resource_group.rg.name
  # location            = data.azurerm_resource_group.rg.location
# }
data "azurerm_container_app_environment" "cae" {
  name                = var.cae_name
  resource_group_name = data.azurerm_resource_group.rg.name
  # location            = data.azurerm_resource_group.rg.location
}


# -------------------------------
# Backend Container App (interno)
# -------------------------------
resource "azurerm_container_app" "backend" {
  name                         = var.backend_ca
  resource_group_name          = data.azurerm_resource_group.rg.name
  # container_app_environment_id = azurerm_container_app_environment.cae.id
  container_app_environment_id = data.azurerm_container_app_environment.cae.id
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
    external_enabled = false
    target_port      = 5000
	transport        = "https"

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
  # container_app_environment_id = azurerm_container_app_environment.cae.id
  container_app_environment_id = data.azurerm_container_app_environment.cae.id
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