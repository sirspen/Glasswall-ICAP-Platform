provider "azurerm" {
  version   = "=2.30.0"
  //tenant_id = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  features {}
}

module "container-registry" {
  source                   = "../../modules/azure/container-registry"
  location                 = "UK South"
  resource_group_name      = "gw-icap-container-registry-resource-group"
}