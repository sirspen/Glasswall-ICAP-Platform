provider "azurerm" {
  tenant_id = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  features {}
}

resource "azurerm_resource_group" "tf_resource_group" {
  name     = "tfstateresourcegroup"
  location = var.location
}

resource "azurerm_storage_account" "tf_storage" {
  name                     = "tfstatestorageaccountgw"
  resource_group_name      = azurerm_resource_group.tf_resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "tf_container" {
  name                  = "tfstatecontainer"
  storage_account_name  = azurerm_storage_account.tf_storage.name
  container_access_type = "private"
}