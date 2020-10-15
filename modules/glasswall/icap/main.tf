
locals {
  cluster_name = "${var.service_name}-cluster"
}


module "azure_cloud_credentials"{
  source                    = "../../rancher/cloud_credentials"
  credential_name           = var.service_name
  client_id                 = var.client_id
  client_secret             = var.client_secret
  subscription_id           = var.subscription_id
}

module "icap_cluster" {
  source              = "../../rancher/cluster"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  cluster_name        = local.cluster_name
  service_name        = var.service_name
  azure_region        = var.azure_region
}

module "icap_master_temp" {
  source              = "../../rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = var.service_name
  node_type           = "Standard_D1_v2"
  resource_group      = module.icap_cluster.resource_group
  cloud_credentials_id  = module.azure_cloud_credentials.id
  azure_region        = var.azure_region
  cluster_virtual_machine_net = local.cluster_name
  cluster_subnet_name         = "${local.cluster_name}-sb-1"
  cluster_subnet_prefix       = "10.20.2.0/24"
}

module "icap_worker_temp" {
  source              = "../../rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = var.service_name
  node_type           = "Standard_D2_v2"
  resource_group      = module.icap_cluster.resource_group
  cloud_credentials_id  = module.azure_cloud_credentials.id
  azure_region        = var.azure_region
  cluster_virtual_machine_net = local.cluster_name
  cluster_subnet_name         = "${local.cluster_name}-sb-1"
  cluster_subnet_prefix       = "10.20.2.0/24"
}


module "icap_master_node_pool"{
  source                   = "../../rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = var.service_name
  cluster_id               = module.icap_cluster.id
  node_pool_template_id    = module.icap_master_temp.id
  resource_group      = module.icap_cluster.resource_group
  node_pool_nodes_qty           = 1
  node_pool_role_control_plane  = true
  node_pool_role_etcd           = true
  node_pool_role_worker         = false
}

module "icap_worker_node_pool"{
  source                   = "../../rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = var.service_name
  cluster_id               = module.icap_cluster.id
  node_pool_template_id    = module.icap_worker_temp.id
  resource_group      = module.icap_cluster.resource_group
  node_pool_nodes_qty      = 1
  node_pool_role_control_plane  = false
  node_pool_role_etcd           = false
  node_pool_role_worker         = true
}