
resource "azurerm_storage_account" "main" {
  name                     = var.service_name
  resource_group_name      = var.resource_group_name
  location                 = var.azure_region
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}