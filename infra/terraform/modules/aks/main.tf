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

variable "node_vm_size" {
  type = string
}

variable "node_count" {
  type = number
}

variable "log_analytics_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.name}-dns"

  default_node_pool {
    name                = "system"
    vm_size             = var.node_vm_size
    node_count          = var.node_count
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed           = true
    azure_rbac_enabled = true
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_id
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}

output "kube_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "kube_rg" {
  value = azurerm_kubernetes_cluster.this.resource_group_name
}
