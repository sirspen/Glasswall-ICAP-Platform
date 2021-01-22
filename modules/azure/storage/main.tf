# Generate random text for a unique storage account name
resource "random_id" "machine_random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group_name
  }
  byte_length = 8
}

resource "azurerm_resource_group" "tf_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "tf_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tf_resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "tf_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.tf_storage.name
  container_access_type = "private"
}

