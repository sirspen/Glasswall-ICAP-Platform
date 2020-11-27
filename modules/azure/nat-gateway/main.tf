resource "azurerm_public_ip" "main" {
  name                = "${var.service_name}-public-ip"
  location            = var.azure_region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    service_name = var.service_name    
  }
}

resource "azurerm_nat_gateway" "main" {
  name                    = "${var.service_name}-nat-gateway"
  location                = var.azure_region
  resource_group_name     = var.resource_group
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  tags = {
    service_name = var.service_name    
  }
}

resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.main.id
}