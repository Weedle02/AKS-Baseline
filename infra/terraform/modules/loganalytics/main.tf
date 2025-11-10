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

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "id" {
  value = azurerm_log_analytics_workspace.this.id
}
