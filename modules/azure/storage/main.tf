resource "azurerm_storage_account" "tf_storage" {
  name                     = "tfstatestorage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "tf_container" {
  name                  = "tfstatecontainer"
  storage_account_name  = azurerm_storage_account.etf_storage.name
  container_access_type = "private"
}