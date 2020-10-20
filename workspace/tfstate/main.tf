provider "azurerm" {
  version   = "=2.30.0"
  tenant_id = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  features {}
}

module "storage" {
  source                   = "../../modules/azure/storage"
  location                 = "UK South"
  resource_group_name      = "tf-state-resource-group"
  storage_account_name     = "gwtfstatestorageaccount"
  storage_container_name   = "tfstatecontainer"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}