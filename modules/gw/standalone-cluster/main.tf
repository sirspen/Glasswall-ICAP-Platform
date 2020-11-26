locals {
  short_region = substr(var.azure_region, 0, 3)
  cluster_name = "${var.service_name}-${local.short_region}-${var.suffix}"
}

module "azure_cloud_credentials" {
  source              = "../../rancher/cloud_credentials"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  credential_name     = local.cluster_name
  client_id           = var.client_id
  client_secret       = var.client_secret
  subscription_id     = var.subscription_id
}

module "master_lb" {
  source                      = "../../azure/internal-load-balancer"
  azure_region                = var.azure_region
  service_name                = local.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = "6443"
  subnet_id                   = module.subnet.id
}

resource "azurerm_lb_backend_address_pool" "master_lbap" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.master_lb.id
  name                            = "MasterNodePool"
}

resource "azurerm_lb_probe" "master_ingress_probe" {
  depends_on                      = [module.master_lb]
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.master_lb.id
  name                            = "MasterNodesUp"
  port                            = "6443"
}

resource "azurerm_lb_rule" "master_ingress_rule_1" {
  depends_on                      = [ azurerm_lb_probe.master_ingress_probe, azurerm_lb_backend_address_pool.master_lbap ]    
  name                            = "MasterIngressRule-1"
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.master_lb.id                           
  frontend_ip_configuration_name  = "Internal"     
  protocol                        = "Tcp"
  frontend_port                   = "6443"
  backend_port                    = "6443"
  probe_id                        = azurerm_lb_probe.master_ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.master_lbap.id
}

data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}

resource "azurerm_dns_a_record" "main_master" {
  name                = "${local.service_name}-k8s-${var.suffix}"
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.master_lb.private_ip_address]
}

module "cluster" {
  source                         = "../../rancher/cluster"
  count                          = var.cluster_quantity

  organisation                   = var.organisation
  environment                    = var.environment
  rancher_admin_url              = var.rancher_admin_url
  rancher_internal_api_url       = var.rancher_internal_api_url
  rancher_admin_token            = var.rancher_admin_token
  rancher_projects               = var.rancher_projects
  cluster_name                   = "${local.cluster_name}${count.index+1}"
  client_id                      = var.client_id
  tenant_id                      = var.tenant_id
  client_secret                  = var.client_secret
  subscription_id                = var.subscription_id
  azure_region                   = var.azure_region
  
  resource_group_name            = module.infra.resource_group_name
  virtual_network_name           = module.infra.network_name
  subnet_name                    = module.infra.subnet_name
  subnet_id                         = module.infra.subnet_id
  
  master_dns_name                   = module.infra.master_lb_dns_name
  master_scaleset_size              = var.master_scaleset_size
  master_scaleset_sku_capacity      = var.master_scaleset_sku_capacity
  master_scaleset_admin_user        = var.master_scaleset_admin_user
  master_lb_backend_address_pool_id = [module.infra.master_lbap_id]
  master_lb_probe_id                = module.infra.master_ingress_probe_id
  
  worker_scaleset_size              = var.worker_scaleset_size
  worker_scaleset_sku_capacity      = var.worker_scaleset_sku_capacity
  worker_scaleset_admin_user        = var.worker_scaleset_admin_user
  worker_lb_backend_address_pool_id = [module.infra.worker_lbap_id]
  worker_lb_probe_id                = module.infra.worker_ingress_probe_id

  os_publisher                      = var.os_publisher
  os_offer                          = var.os_offer
  os_sku                            = var.os_sku
  os_version                        = var.os_version
  public_key_openssh                = var.public_key_openssh
}