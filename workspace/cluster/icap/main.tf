locals {
  cluster_name            = "${var.service_name}-${var.suffix}"
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
  resource_group_name         = var.rancher_resource_group
  virtual_network_name        = var.rancher_network
  remote_virtual_network_id   = module.network.id
}

resource "azurerm_virtual_network_peering" "icap_cluster" {
  name                        = "peerICAPtoRancher"
  resource_group_name         = module.resource_group.name
  virtual_network_name        = module.network.name
  remote_virtual_network_id   = var.rancher_network_id
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

module "lb" {
  source                      = "../../../modules/azure/load-balancer"
  azure_region                = var.azure_region
  service_name                = var.service_name
  resource_group              = module.resource_group.name
  lb_probe_port               = 6443
}

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
# scaleset_name               = module.scaleset.name
  scaleset_name               = "${local.cluster_name}-master"
}
/*
data "template_file" "master_scaleset_nodes" {
  template                        = file("../../../scripts/user-data.template")
  depends_on                      = [module.icap_cluster]
  vars {
    cluster_name                  = "${local.cluster_name}"
    rancher_agent_version         = "v2.5.1"
    rancher_server_url            = var.rancher_admin_url
    rancher_agent_token           = module.icap_cluster.token
    node_pool_role                = "master"
    public_key_openssh            = var.public_key_openssh
  }
}*/

module "master_scaleset" {
    source                      = "../../../modules/azure/scale-set"
    depends_on                  = [module.icap_cluster]
    organisation                = var.organisation
    environment                 = var.environment
    service_name                = "${local.cluster_name}-master"
    service_role                = "master"
    resource_group              = module.resource_group.name
    subnet_id                   = module.subnet.id
    region                      = var.azure_region
    size                        = "Standard_D1_v2"
    os_publisher                = var.os_publisher
    os_offer                    = var.os_offer
    os_sku                      = var.os_sku
    os_version                  = var.os_version
    admin_username              = "azure-user"
    #custom_data_file_path      = data.template_file.master_scaleset_nodes.rendered
    custom_data_file_path       = templatefile("${path.module}/tmpl/user-data.template",{
      cluster_name              = "${local.cluster_name}"
      rancher_agent_version     = "v2.5.1"
      rancher_server_url        = var.rancher_admin_url
      rancher_agent_token       = module.icap_cluster.token
      node_pool_role            = "master"
      public_key_openssh        = var.public_key_openssh
      rancher_ca_checksum       = ""
    })
    public_key_openssh          = var.public_key_openssh
    lb_backend_address_pool_id  = module.lb.bap_id
    lb_probe_id                 = module.lb.probe_id
  }
/*
data "template_file" "worker_scaleset_nodes" {
  template                        = file("../../../scripts/user-data.template")
  depends_on                      = [module.icap_cluster]
  vars {
    cluster_name                  = "${local.cluster_name}"
    rancher_agent_version         = "v2.5.1"
    rancher_server_url            = var.rancher_admin_url
    rancher_agent_token           = module.icap_cluster.token
    node_pool_role                = "worker"
    public_key_openssh            = var.public_key_openssh
  }
}*/

module "worker_scaleset" {
    source                      = "../../../modules/azure/scale-set"
    depends_on                  = [module.icap_cluster]
    organisation                = var.organisation
    environment                 = var.environment
    service_name                = "${local.cluster_name}-master"
    service_role                = "worker"
    resource_group              = module.resource_group.name
    subnet_id                   = module.subnet.id
    region                      = var.azure_region
    size                        = "Standard_D2_v2"
    os_publisher                = var.os_publisher
    os_offer                    = var.os_offer
    os_sku                      = var.os_sku
    os_version                  = var.os_version
    admin_username              = "azure-user"
    custom_data_file_path       = templatefile("${path.module}/tmpl/user-data.template",{
      cluster_name                  = "${local.cluster_name}"
      rancher_agent_version         = "v2.5.1"
      rancher_server_url            = var.rancher_admin_url
      rancher_agent_token           = module.icap_cluster.token
      node_pool_role                = "worker"
      public_key_openssh            = var.public_key_openssh
      rancher_ca_checksum           = ""
    })
    #custom_data_file_path      = data.template_file.worker_scaleset_nodes.rendered
    public_key_openssh          = var.public_key_openssh
    lb_backend_address_pool_id  = module.lb.bap_id
    lb_probe_id                 = module.lb.probe_id
  }
