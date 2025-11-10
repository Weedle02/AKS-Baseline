terraform {
  required_version = "~> 1.6"
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.102" }
  }
}

provider "azurerm" {
  features {}
}
