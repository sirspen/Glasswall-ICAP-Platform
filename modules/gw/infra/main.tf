
module "resource_group" {
  source                  = "../../azure/resource-group"
  name                    = var.service_name
  region                  = var.azure_region
}

module "availability_set" {
  source                  = "../../azure/availability-set"
  name                    = var.service_name
  region                  = var.azure_region
  resource_group          = module.resource_group.name
}

module "network" {
  source                  = "../../azure/network"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  region                  = var.azure_region
  service_name            = var.service_name
  address_space           = var.cluster_address_space
}


module "subnet" {
  source                  = "../../azure/subnet"
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  service_name            = var.service_name
  address_prefixes        = var.cluster_subnet_cidr
}

resource "azurerm_virtual_network_peering" "rancher_server" {
  name                        = "${var.suffix}PeerRanchertoICAP"
  resource_group_name         = var.rancher_resource_group
  virtual_network_name        = var.rancher_network
  remote_virtual_network_id   = module.network.id
}

resource "azurerm_virtual_network_peering" "icap_cluster" {
  name                        = "${var.suffix}PeerICAPtoRancher"
  resource_group_name         = module.resource_group.name
  virtual_network_name        = module.network.name
  remote_virtual_network_id   = var.rancher_network_id
}

module "worker_lb" {
  source                      = "../../azure/load-balancer"
  azure_region                = var.azure_region
  service_name                = var.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = var.backend_port
}

resource "azurerm_lb_backend_address_pool" "worker_lbap" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "WorkerNodePool"
}

resource "azurerm_lb_probe" "worker_ingress_probe" {
  depends_on                      = [module.worker_lb]
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "WorkerNodesUp"
  port                            = var.backend_port
}

resource "azurerm_lb_rule" "worker_ingress_rule_1" {
  depends_on                      = [ azurerm_lb_probe.worker_ingress_probe, azurerm_lb_backend_address_pool.worker_lbap ]    
  name                            = "WorkerIngressRule-1"
  #location                       = var.azure_region
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id                           
  frontend_ip_configuration_name  = "PublicIPAddress"     
  protocol                        = "Tcp"
  frontend_port                   = var.public_port
  backend_port                    = var.backend_port
  probe_id                        = azurerm_lb_probe.worker_ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.worker_lbap.id
}


data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}

resource "azurerm_dns_a_record" "main" {
  name                = var.service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.worker_lb.public_ip_address]
}