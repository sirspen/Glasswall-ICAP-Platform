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

resource "azurerm_lb_rule" "this" {
  resource_group_name            = azurerm_resource_group.this.name
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "gw-icap-loadbalancer-rule"
  protocol                       = "Tcp"
  frontend_port                  = 1344
  backend_port                   = 1344
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_backend_address_pool" "this" {
  resource_group_name = azurerm_resource_group.this.name
  loadbalancer_id     = azurerm_lb.this.id
  name                = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  network_interface_id    = var.network_interface_id
  ip_configuration_name   = "gw-icap-ip-configuration-association"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}

