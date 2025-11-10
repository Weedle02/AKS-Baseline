locals {
  name = "${var.prefix}-stg"
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

module "law" {
  source   = "../../modules/loganalytics"
  name     = "${local.name}-law"
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
}

module "acr" {
  source   = "../../modules/acr"
  name     = "${local.name}acr"
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
}

module "kv" {
  source    = "../../modules/keyvault"
  name      = "${local.name}-kv"
  rg_name   = azurerm_resource_group.rg.name
  location  = var.location
  tenant_id = var.tenant_id
}

module "aks" {
  source           = "../../modules/aks"
  name             = "${local.name}-aks"
  rg_name          = azurerm_resource_group.rg.name
  location         = var.location
  node_vm_size     = var.node_vm_size
  node_count       = var.node_count
  log_analytics_id = module.law.id
  tags             = var.tags
}

output "aks_name" {
  value = module.aks.kube_name
}

output "aks_rg" {
  value = module.aks.kube_rg
}

output "acr_login_server" {
  value = module.acr.login_server
}
