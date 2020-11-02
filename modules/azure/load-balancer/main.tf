/*
module "loadbalancer {
  source ../this-folder
  service_name = var.service_name
  azure_region = var.azure_region

}"
*/

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.service_name}-public-ip"
  location            = var.azure_region
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
  tags = {
    service_name = var.service_name    
  }
}

resource "azurerm_lb" "lb" {
  name                = var.service_name
  location            = var.azure_region
  resource_group_name = var.resource_group
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_bap" {
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "tcp-running-probe"
  port                = var.lb_probe_port
}