locals {
  short_region = substr(var.azure_region, 0, 3)
  cluster_name = "${var.service_name}-${local.short_region}-${var.suffix}"
}

module "resource_group" {
  source                  = "../../azure/resource-group"
  name                    = var.service_name
  region                  = var.azure_region
}

module "azure_cloud_credentials" {
  source                 = "../../rancher/cloud_credentials"
  rancher_admin_url      = var.rancher_admin_url
  rancher_admin_token    = var.rancher_admin_token
  credential_name        = local.cluster_name
  client_id              = var.client_id
  client_secret          = var.client_secret
  subscription_id        = var.subscription_id
}

module "worker_lb" {
  source                 = "../../azure/load-balancer"
  azure_region           = var.azure_region
  service_name           = local.cluster_name
  resource_group         = module.resource_group.name
  lb_probe_port          = var.cluster_backend_port
}
/*
module "worker_lbint" {
  source                      = "../../azure/internal-load-balancer"
  azure_region                = var.azure_region
  service_name                = local.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = var.backend_port
}*/

resource "azurerm_lb_backend_address_pool" "worker_lbap" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "WorkerNodePool"
}
/*
resource "azurerm_lb_backend_address_pool" "worker_lbap_int" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "InternalWorkerNodePool"
}
*/
resource "azurerm_lb_probe" "worker_ingress_probe" {
  depends_on                      = [module.worker_lb]
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "WorkerNodesUp"
  port                            = var.cluster_backend_port
}

resource "azurerm_lb_rule" "worker_ingress_rule_1" {
  depends_on                      = [ azurerm_lb_probe.worker_ingress_probe, azurerm_lb_backend_address_pool.worker_lbap ]    
  name                            = "WorkerIngressRule-1"
  #location                       = var.azure_region
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id                           
  frontend_ip_configuration_name  = "Public"     
  protocol                        = "Tcp"
  frontend_port                   = var.cluster_public_port
  backend_port                    = var.cluster_backend_port
  probe_id                        = azurerm_lb_probe.worker_ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.worker_lbap.id
}
/*
resource "azurerm_lb_rule" "worker_internal_ingress_rule_1" {
  depends_on                      = [ azurerm_lb_probe.worker_ingress_probe, azurerm_lb_backend_address_pool.worker_lbap ]    
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
}*/
/*
module "master_lb" {
  source                      = "../../azure/internal-load-balancer"
  azure_region                = var.azure_region
  service_name                = local.cluster_name
  resource_group              = var.cluster_resource_group_name
  lb_probe_port               = "6443"
  subnet_id                   = var.cluster_subnet_id
}

resource "azurerm_lb_backend_address_pool" "master_lbap" {
  resource_group_name             = var.cluster_resource_group_name
  loadbalancer_id                 = module.master_lb.id
  name                            = "MasterNodePool"
}

resource "azurerm_lb_probe" "master_ingress_probe" {
  depends_on                      = [module.master_lb]
  resource_group_name             = var.cluster_resource_group_name
  loadbalancer_id                 = module.master_lb.id
  name                            = "MasterNodesUp"
  port                            = "6443"
}

resource "azurerm_lb_rule" "master_ingress_rule_1" {
  depends_on                      = [ azurerm_lb_probe.master_ingress_probe, azurerm_lb_backend_address_pool.master_lbap ]    
  name                            = "MasterIngressRule-1"
  resource_group_name             = var.cluster_resource_group_name
  loadbalancer_id                 = module.master_lb.id                           
  frontend_ip_configuration_name  = "Private"     
  protocol                        = "Tcp"
  frontend_port                   = "6443"
  backend_port                    = "6443"
  probe_id                        = azurerm_lb_probe.master_ingress_probe.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.master_lbap.id
}*/

data "azurerm_dns_zone" "main" {
  name                = var.dns_zone
  resource_group_name = var.rancher_resource_group
}

/*data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}*/
/*
resource "azurerm_dns_a_record" "main_master" {
  name                = "${local.cluster_name}-k8s-${var.suffix}"
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.master_lb.private_ip_address]
}
*/
resource "azurerm_dns_a_record" "main_worker" {
  name                = local.cluster_name
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = var.rancher_resource_group
  ttl                 = 300
  records             = [module.worker_lb.public_ip_address]
}

module "security_group" {
  source               = "../../azure/security-group"
  service_name         = "${var.service_name}-sg"
  azure_region         = var.azure_region
  resource_group_name  = module.resource_group.name
  security_group_rules = var.security_group_rules
}

module "default_master_template" {
  source                      = "../../rancher/node_template"
  rancher_admin_url           = var.rancher_internal_api_url
  rancher_admin_token         = var.rancher_admin_token
  service_name                = "${local.cluster_name}-master-default"
  node_type                   = var.master_scaleset_size
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = var.rancher_resource_group
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = var.cluster_network_name
  cluster_subnet_name         = var.cluster_subnet_name
  public_key_openssh          = var.public_key_openssh
}

module "default_worker_template" {
  source                      = "../../rancher/node_template"
  rancher_admin_url           = var.rancher_internal_api_url
  rancher_admin_token         = var.rancher_admin_token
  service_name                = "${local.cluster_name}-stateful-default"
  node_type                   = var.worker_scaleset_size
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = var.rancher_resource_group
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = var.cluster_network_name
  cluster_subnet_name         = var.cluster_subnet_name
  public_key_openssh          = var.public_key_openssh
}

module "cluster" {
  source                             = "../../rancher/cluster"
  organisation                       = var.organisation
  environment                        = var.environment
  rancher_admin_url                  = var.rancher_admin_url
  rancher_internal_api_url           = var.rancher_internal_api_url
  rancher_admin_token                = var.rancher_admin_token
  rancher_projects                   = var.rancher_projects
  cluster_stage1_apps                = var.cluster_stage1_apps
  cluster_name                       = local.cluster_name
  client_id                          = var.client_id
  tenant_id                          = var.tenant_id
  client_secret                      = var.client_secret
  subscription_id                    = var.subscription_id
  azure_region                       = var.azure_region
  resource_group_name                = module.resource_group.name
  security_group_id                  = module.security_group.id
  virtual_network_name               = var.cluster_network_name
  subnet_name                        = var.cluster_subnet_name
  subnet_id                          = var.cluster_subnet_id
  master_scaleset_size               = var.master_scaleset_size
  master_scaleset_sku_capacity       = var.master_scaleset_sku_capacity
  master_scaleset_admin_user         = var.master_scaleset_admin_user
  
  worker_scaleset_size               = var.worker_scaleset_size
  worker_scaleset_sku_capacity       = var.worker_scaleset_sku_capacity
  worker_scaleset_admin_user         = var.worker_scaleset_admin_user
  worker_lb_backend_address_pool_id  = [azurerm_lb_backend_address_pool.worker_lbap.id]
  worker_lb_probe_id                 = azurerm_lb_probe.worker_ingress_probe.id

  os_publisher                       = var.os_publisher
  os_offer                           = var.os_offer
  os_sku                             = var.os_sku
  os_version                         = var.os_version
  public_key_openssh                 = var.public_key_openssh
  helm_chart_repo_url                = var.helm_chart_repo_url
  docker_config_json                 = var.docker_config_json

  default_worker_template_id        = module.default_worker_template.id
  default_master_template_id        = module.default_master_template.id
  add_master_scaleset               = true #this also manages the master nodepool
  add_worker_scaleset               = true
  add_worker_nodepool               = false
  cluster_worker_labels             = {}
  cluster_worker_taints             = []
}
