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

resource "azurerm_lb_rule" "ingress_rule" {
  name                            = "ingress-rule"
  #location                        = var.azure_region
  resource_group_name             = var.resource_group
  loadbalancer_id                 = azurerm_lb.lb.id                            
  frontend_ip_configuration_name  = "PublicIPAddress"     
  protocol                        = "Tcp"
  frontend_port                   = 443
  backend_port                    = 443
  probe_id                        = azurerm_lb_probe.ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lb_bap.id
}

resource "azurerm_lb_rule" "k8sapi_rule" {
  name                            = "master-ingress-lbrule"
  #location                       = var.azure_region
  resource_group_name             = var.resource_group
  loadbalancer_id                 = azurerm_lb.lb.id                            
  frontend_ip_configuration_name  = "PublicIPAddress"     
  protocol                        = "Tcp"
  frontend_port                   = 6443
  backend_port                    = 6443
  probe_id                        = azurerm_lb_probe.k8sapi_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lb_bap.id
}
resource "azurerm_lb_backend_address_pool" "lb_bap" {
  resource_group_name             = var.resource_group
  loadbalancer_id                 = azurerm_lb.lb.id
  name                            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "ingress_probe" {
  resource_group_name             = var.resource_group
  loadbalancer_id                 = azurerm_lb.lb.id
  name                            = "https-up"
  port                            = 443
}

resource "azurerm_lb_probe" "k8sapi_probe" {
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "k8sapi-up"
  port                = 6443
}