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
  tags = {
    service_name = var.service_name    
    service_group = var.service_group    
  }
}
/*
module "nat" {
  source    = "../nat-gateway"
  service_name    = var.service_name
  resource_group  = var.resource_group
  azure_region    = var.azure_region
}*/