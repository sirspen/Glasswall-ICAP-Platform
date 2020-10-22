
locals {
  cluster_name = "${var.service_name}-${var.suffix}"
}

provider "azurerm" {
  version = "=2.30.0"
  features {}
}

module "azure_cloud_credentials"{
  source                    = "../../../modules/rancher/cloud_credentials"
  rancher_admin_url         = var.rancher_admin_url
  rancher_admin_token       = var.rancher_admin_token
  credential_name           = local.cluster_name
  client_id                 = var.client_id
  client_secret             = var.client_secret
  subscription_id           = var.subscription_id
}

module "icap_cluster" {
  source              = "../../../modules/rancher/cluster"
  organisation        = var.organisation
  environment         = var.environment
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  cluster_name        = local.cluster_name
  service_name        = var.service_name
  azure_region        = var.azure_region
  address_space       = var.address_space
  subnet_cidr         = var.subnet_cidr
  client_id           = var.client_id
  tenant_id           = var.tenant_id
  client_secret       = var.client_secret
  subscription_id     = var.subscription_id
}

module "icap_master_temp" {
  source              = "../../../modules/rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = "${var.service_name}-mstr-temp"
  node_type           = "Standard_D1_v2"
  custom_data         = var.node_custom_data
  resource_group      = module.icap_cluster.resource_group
  cloud_credentials_id        = module.azure_cloud_credentials.id
  azure_region                = var.azure_region
  cluster_virtual_machine_net = module.icap_cluster.network
  cluster_subnet_name         = module.icap_cluster.subnet
  cluster_subnet_prefix       = var.cluster_subnet_prefix
}

module "icap_worker_temp" {
  source              = "../../../modules/rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = "${var.service_name}-wkr-temp"
  node_type           = "Standard_D2_v2"
  custom_data         = var.node_custom_data
  resource_group      = module.icap_cluster.resource_group
  cloud_credentials_id        = module.azure_cloud_credentials.id
  azure_region                = var.azure_region
  cluster_virtual_machine_net = module.icap_cluster.network
  cluster_subnet_name         = module.icap_cluster.subnet
  cluster_subnet_prefix       = var.cluster_subnet_prefix
}

module "icap_master_node_pool"{
  source                   = "../../../modules/rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = "${var.service_name}-mstr"
  cluster_id               = module.icap_cluster.cluster_id
  node_pool_template_id    = module.icap_master_temp.id
  resource_group           = module.icap_cluster.resource_group
  node_pool_nodes_qty           = 1
  node_pool_role_control_plane  = true
  node_pool_role_etcd           = true
  node_pool_role_worker         = false
}

module "icap_worker_node_pool"{
  source                   = "../../../modules/rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = "${var.service_name}-wkr"
  cluster_id               = module.icap_cluster.cluster_id
  node_pool_template_id    = module.icap_worker_temp.id
  resource_group           = module.icap_cluster.resource_group
  node_pool_nodes_qty      = 1
  node_pool_role_control_plane  = false
  node_pool_role_etcd           = false
  node_pool_role_worker         = true
}
