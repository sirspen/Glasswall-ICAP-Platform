resource "azurerm_resource_group" "gw-icap-loadbalancer-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "gw-icap-public-ip-for-lb" {
  name                = "gw-icap-public-ip-for-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.gw-icap-loadbalancer-rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "gw-icap-loadbalancer" {
  name                = "gw-icap-loadbalancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.gw-icap-loadbalancer-rg.name

  frontend_ip_configuration {
    name                 = "gw-icap-public-ip-address"
    public_ip_address_id = azurerm_public_ip.gw-icap-public-ip-for-lb.id
  }
}