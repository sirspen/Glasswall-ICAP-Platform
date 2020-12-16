
locals {
  service_name = "${var.service_name}-${var.suffix}1"
  service_group = var.service_name
}

module "resource_group" {
  source                  = "../../azure/resource-group"
  name                    = local.service_name
  region                  = var.azure_region
}

module "availability_set" {
  source                  = "../../azure/availability-set"
  name                    = local.service_name
  region                  = var.azure_region
  resource_group          = module.resource_group.name
}

module "network" {
  source                  = "../../azure/network"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  region                  = var.azure_region
  service_name            = local.service_name
  address_space           = var.cluster_address_space
}


module "subnet" {
  source                  = "../../azure/subnet"
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  service_name            = local.service_name
  address_prefixes        = var.cluster_subnet_cidr
}

module "nat" {
  source    = "../../azure/nat-gateway"
  service_name    = var.service_name
  resource_group  = module.resource_group.name
  azure_region    = var.azure_region
}

resource "azurerm_subnet_nat_gateway_association" "main" {
  subnet_id      = module.subnet.id
  nat_gateway_id = module.nat.nat_gateway_id
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

module "int_worker_lb" {
  source                      = "../../azure/internal-load-balancer"
  azure_region                = var.azure_region
  service_name                = local.service_name
  service_group               = var.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = "80"
  subnet_id                   = module.subnet.id
}

resource "azurerm_lb_backend_address_pool" "int_worker_lbap" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.int_worker_lb.id
  name                            = "InternalWorkerNodePool"
}

resource "azurerm_lb_probe" "int_worker_ingress_probe" {
  depends_on                      = [module.int_worker_lb]
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.int_worker_lb.id
  name                            = "InternalWorkers"
  port                            = "80"
}

resource "azurerm_lb_rule" "int_worker_ingress_rules" {
  depends_on                      = [module.int_worker_lb, azurerm_lb_probe.int_worker_ingress_probe, azurerm_lb_backend_address_pool.int_worker_lbap ]
  for_each                         = var.cluster_internal_services

  name                            = each.key
  protocol                        = each.value.protocol
  frontend_port                   = each.value.frontend_port
  backend_port                    = each.value.backend_port
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.int_worker_lb.id                           
  frontend_ip_configuration_name  = "Private"     
  probe_id                        = azurerm_lb_probe.int_worker_ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.int_worker_lbap.id
}

module "worker_lb" {
  source                      = "../../azure/load-balancer"
  azure_region                = var.azure_region
  service_name                = local.service_name
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
  depends_on                      = [ module.worker_lb, azurerm_lb_probe.worker_ingress_probe, azurerm_lb_backend_address_pool.worker_lbap ]    
  name                            = "WorkerIngressRule-1"
  #location                       = var.azure_region
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id                           
  frontend_ip_configuration_name  = "Public"     
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

resource "azurerm_dns_a_record" "main_int_worker" {
  name                = "${local.service_name}-int"
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.int_worker_lb.private_ip_address]
}

resource "azurerm_dns_a_record" "main_worker" {
  name                = var.service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.worker_lb.public_ip_address]
}