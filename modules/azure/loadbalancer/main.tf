resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "this" {
  name                = "gw-icap-public-ip-for-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = "gw-icap-loadbalancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "gw-icap-public-ip-address"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

