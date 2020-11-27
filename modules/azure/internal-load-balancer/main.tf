resource "azurerm_lb" "main" {
  name                            = "${var.service_name}-int"
  location                        = var.azure_region
  resource_group_name             = var.resource_group
  sku                             = "Standard"
  frontend_ip_configuration {
    name                          = "Private"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}