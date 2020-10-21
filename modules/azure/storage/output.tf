output "storage_account_name" {
  value = azurerm_storage_account.tf_storage.name
}

output "container_name" {
  value = azurerm_storage_container.tf_container.name
}

output "access_key" {
  value = azurerm_storage_account.tf_storage.primary_access_key
}