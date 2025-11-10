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

variable "tenant_id" {
  type = string
}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 14
}

output "kv_id" {
  value = azurerm_key_vault.this.id
}

output "kv_name" {
  value = azurerm_key_vault.this.name
}
