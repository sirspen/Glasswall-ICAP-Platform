terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-icap-dev-multi-cluster-terraform.tfstate"
  }
}

locals {
  short_region_r1            = substr(var.azure_region_r1, 0, 3)
  short_region_r2            = substr(var.azure_region_r2, 0, 3)
  service_name            = "${var.organisation}-${var.project}-${var.environment}"
  service_name_nodash_r1     = "${var.organisation}icap${var.environment}${local.short_region_r1}"
  service_name_nodash_r2     = "${var.organisation}icap${var.environment}${local.short_region_r2}"
  rancher_api_url         = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
  rancher_internal_api_url = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
  rancher_network          = data.terraform_remote_state.rancher_server.outputs.network
  rancher_server_url       = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
  rancher_admin_token      = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network_id       = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group   = data.terraform_remote_state.rancher_server.outputs.resource_group
  public_key_openssh       = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-dev-multi-cluster-terraform.tfstate"
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = "gw-icap-keyvault"
  resource_group_name = "keyvault"
}

data "azurerm_key_vault_secret" "az-client-id" {
  name         = "az-client-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-client-secret" {
  name         = "az-client-secret"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-subscription-id" {
  name         = "az-subscription-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

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
  lb_probe_port               = 1345
}

resource "azurerm_lb_backend_address_pool" "lb_bap_1" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "Cluster1NodePool"
}

resource "azurerm_lb_probe" "ingress_probe_1" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "nodes-up-1"
  port                            = var.backend_port
}

resource "azurerm_lb_rule" "ingress_rule_1" {
  name                            = "ingress-rule-1"
  #location                        = var.azure_region
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id                           
  frontend_ip_configuration_name  = "PublicIPAddress"     
  protocol                        = "Tcp"
  frontend_port                   = var.public_port
  backend_port                    = var.backend_port
  probe_id                        = azurerm_lb_probe.ingress_probe_1.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lb_bap_1.id
}
/*
resource "azurerm_lb_backend_address_pool" "lb_bap_2" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "Cluster2NodePool"
}

resource "azurerm_lb_probe" "ingress_probe_2" {
  resource_group_name             = module.resource_group.name
  loadbalancer_id                 = module.worker_lb.id
  name                            = "nodes-up-2"
  port                            = var.backend_port
>>>>>>> Update git server version, decrease dns ttl and change lb port
}

module "icap_cluster_r1" {
  source                       = "../../modules/gw/cluster"
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  suffix                       = "r1"
  azure_region                 = var.azure_region_r1
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  cluster_backend_port         = var.backend_port
  cluster_public_port          = var.public_port
  cluster_address_space        = var.cluster_address_space_r1
  cluster_subnet_cidr          = var.cluster_subnet_cidr_r1
  cluster_subnet_prefix        = var.cluster_subnet_prefix_r1
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  master_scaleset_size         = "Standard_DS4_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 2
  worker_scaleset_size         = "Standard_DS4_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 2
}

module "icap_cluster_r2" {
  source                       = "../../modules/gw/cluster"
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  suffix                       = "r2"
  service_name                 = local.service_name
  azure_region                 = var.azure_region_r2
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  cluster_backend_port         = var.backend_port
  cluster_public_port          = var.public_port
  cluster_address_space        = var.cluster_address_space_r2
  cluster_subnet_cidr          = var.cluster_subnet_cidr_r2
  cluster_subnet_prefix        = var.cluster_subnet_prefix_r2
  #cluster_address_space        = ["172.32.0.0/12", "192.168.0.0/16"]
  #cluster_subnet_cidr          = ["172.46.0.0/16"]
  #cluster_subnet_prefix        = "172.46.2.0/24"
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  master_scaleset_size         = "Standard_DS4_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 2
  worker_scaleset_size         = "Standard_DS4_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 2
}