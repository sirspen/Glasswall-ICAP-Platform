
module "resource_group" {
  source                  = "../../modules/azure/resource_group"
  name                    = local.service_name
  region                  = var.azure_region
}

module "availability_set" {
  source                  = "../../modules/azure/availability-set"
  name                    = local.service_name
  region                  = var.azure_region
  resource_group          = module.resource_group.name
}

module "network" {
  source                  = "../../modules/azure/network"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  region                  = var.azure_region
  service_name            = local.service_name
  address_space           = var.address_space
}

module "subnet" {
  source                  = "../../modules/azure/subnet"
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  service_name            = local.service_name
  address_prefixes        = var.subnet_cidr
}

resource "azurerm_virtual_network_peering" "rancher_server" {
  name                        = "peerRanchertoICAP"
  resource_group_name         = local.rancher_resource_group
  virtual_network_name        = local.rancher_network
  remote_virtual_network_id   = module.network.id
}

resource "azurerm_virtual_network_peering" "icap_cluster" {
  name                        = "peerICAPtoRancher"
  resource_group_name         = module.resource_group.name
  virtual_network_name        = module.network.name
  remote_virtual_network_id   = local.rancher_network_id
}


module "azure_cloud_credentials"{
  source                      = "../../modules/rancher/cloud_credentials"
  rancher_admin_url           = local.rancher_api_url
  rancher_admin_token         = local.rancher_admin_token
  credential_name             = local.service_name
  client_id                   = data.azurerm_key_vault_secret.az-client-id.value
  client_secret               = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id             = data.azurerm_key_vault_secret.az-subscription-id.value
}

module "worker_lb" {
  source                      = "../../modules/azure/load-balancer"
  azure_region                = var.azure_region
  service_name                = local.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = var.worker_node_port
}

resource "azurerm_lb_backend_address_pool" "worker_lbap" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "WorkerNodePool"
}

resource "azurerm_lb_probe" "worker_ingress_probe" {
    depends_on                    = module.worker_lb
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
  probe_id                        = azurerm_lb_probe.worker_ingress_probe
  backend_address_pool_id         = azurerm_lb_backend_address_pool.worker_lbap.id
}
