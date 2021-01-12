output "storage_resource_group" {
  value = azurerm_resource_group.tf_resource_group
}

output "storage_account_name" {
  value = azurerm_storage_account.tf_storage.name
}

output "storage_container_name" {
  value = azurerm_storage_container.tf_container.name
}

output "storage_access_key" {
  value = azurerm_storage_account.tf_storage.primary_access_key
}