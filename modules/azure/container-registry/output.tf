output "container_registry_url" {
  value = azurerm_container_registry.acr.login_server
}