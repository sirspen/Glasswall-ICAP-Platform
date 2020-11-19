provider "azurerm" {
  version   = "=2.30.0"
  features {}
}

module "container-registry" {
  source                   = "../../modules/azure/container-registry"
  location                 = "UK South"
  resource_group_name      = "gw-icap-container-registry-resource-group"
}