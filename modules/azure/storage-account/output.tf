
output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "primary_access_key" {
  value = azurerm_storage_account.main.primary_access_key
}

output "primary_access_region" {
    value = azurerm_storage_account.main.primary_location
}

output "secondary_access_key" {
  value = azurerm_storage_account.main.secondary_access_key
}

output "secondary_access_region" {
  value = azurerm_storage_account.main.secondary_location
}