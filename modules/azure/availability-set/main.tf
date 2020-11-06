

resource "azurerm_availability_set" "availability_set" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
}