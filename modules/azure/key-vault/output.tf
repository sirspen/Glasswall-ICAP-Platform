

output "keyvault_id" {
  value = azurerm_key_vault.main.id
}

output "keyvault_uri" {
  value = azurerm_key_vault.main.vault_uri
}

output "keyvault_resource_group" {
  value = azurerm_resource_group.keyvault.name
}

output "keyvault_name" {
  value = var.service_name
}
