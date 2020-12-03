
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.service_name}-public-ip"
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    org          = var.organisation
    environment  = var.environment
    service_name = var.service_name    
    service_type = var.service_type
  }
}