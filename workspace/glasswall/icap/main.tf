data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "rancher-server-terraform.tfstate"
  }
}

locals {
  cluster_name            = "${var.service_name}-${var.suffix}"
  #rancher_network        = "gw-icap-p2-dev-ukw"
  rancher_network         = data.terraform_remote_state.rancher_server.outputs.network
  #rancher_network_id     = "/subscriptions/b8177f86-515f-4bff-bd08-1b9535dbc31b/resourceGroups/gw-icap-p2-dev-ukw/providers/Microsoft.Network/virtualNetworks/gw-icap-p2-dev-ukw"
  rancher_network_id      = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group  = data.terraform_remote_state.rancher_server.outputs.resource_group
}

module "resource_group" {
  source                  = "../../../modules/azure/resource_group"
  name                    = local.cluster_name
  region                  = var.azure_region
}

module "network" {
  source                  = "../../../modules/azure/network"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  region                  = var.azure_region
  service_name            = local.cluster_name
  address_space           = var.address_space
}

module "subnet" {
  source                  = "../../../modules/azure/subnet"
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  service_name            = local.cluster_name
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
  source                      = "../../../modules/rancher/cloud_credentials"
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  credential_name             = local.cluster_name
  client_id                   = var.client_id
  client_secret               = var.client_secret
  subscription_id             = var.subscription_id
}

#module "scaleset" {
#  source                  = "../../../modules/azure/scaleset"
  /*
  organisation          = var.organisation
  environment           = var.environment
  service_name
  resource_group
  subnet_id
  public_ip_id
  region
  size
  os_publisher
  os_offer
  os_sku
  os_version
  admin_username
  custom_data_file_path
  public_key_openssh
  lb_backend_address_pool_id
  lb_nat_pool_id
  lb_probe_id
  */
#}

module "icap_cluster" {
  source                      = "../../../modules/rancher/cluster"
  organisation                = var.organisation
  environment                 = var.environment
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  cluster_name                = local.cluster_name
  service_name                = var.service_name
  azure_region                = var.azure_region
  client_id                   = var.client_id
  tenant_id                   = var.tenant_id
  client_secret               = var.client_secret
  subscription_id             = var.subscription_id
  resource_group              = module.resource_group.name
  virtual_network_name        = module.network.name
  subnet_name                 = module.subnet.name
}

module "icap_master_temp" {
  source                      = "../../../modules/rancher/node_template"
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  service_name                = "${var.service_name}-mstr-temp"
  node_type                   = "Standard_D1_v2"
  custom_data                 = var.node_custom_data
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = module.resource_group.name
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = module.network.name
  cluster_subnet_name         = module.subnet.name
}

module "icap_worker_temp" {
  source                      = "../../../modules/rancher/node_template"
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  service_name                = "${var.service_name}-wkr-temp"
  node_type                   = "Standard_D2_v2"
  custom_data                 = var.node_custom_data
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = module.resource_group.name
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = module.network.name
  cluster_subnet_name         = module.subnet.name
}

module "icap_master_node_pool"{
  source                        = "../../../modules/rancher/node_pool"
  cluster_id                    = module.icap_cluster.cluster_id
  node_pool_template_id         = module.icap_master_temp.id
  resource_group                = module.resource_group.name
  rancher_admin_url             = var.rancher_admin_url
  rancher_admin_token           = var.rancher_admin_token
  service_name                  = "${var.service_name}-mstr"
  node_pool_nodes_qty           = 1
  node_pool_role_control_plane  = true
  node_pool_role_etcd           = true
  node_pool_role_worker         = false
}

module "icap_worker_node_pool"{
  source                        = "../../../modules/rancher/node_pool"
  cluster_id                    = module.icap_cluster.cluster_id
  node_pool_template_id         = module.icap_worker_temp.id
  resource_group                = module.resource_group.name
  rancher_admin_url             = var.rancher_admin_url
  rancher_admin_token           = var.rancher_admin_token
  service_name                  = "${var.service_name}-wkr"
  node_pool_nodes_qty           = 1
  node_pool_role_control_plane  = false
  node_pool_role_etcd           = false
  node_pool_role_worker         = true
}
