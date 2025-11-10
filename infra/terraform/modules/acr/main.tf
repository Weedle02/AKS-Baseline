terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.102" }
  }
}

provider "azurerm" {
  features {}
}

variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

output "login_server" {
  value = azurerm_container_registry.this.login_server
}
