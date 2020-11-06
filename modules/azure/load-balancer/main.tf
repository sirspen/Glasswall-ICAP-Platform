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
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    service_name = var.service_name    
  }
}

resource "azurerm_lb" "lb" {
  name                = var.service_name
  location            = var.azure_region
  resource_group_name = var.resource_group
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}