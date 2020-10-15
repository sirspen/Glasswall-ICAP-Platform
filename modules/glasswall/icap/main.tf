
locals {
  service_name = "${var.service_name}-cluster"
}

resource "rancher2_cloud_credential" "cluster_credentials" {
  name = "Azure Credentials"
  azure_credential_config {
    client_id = var.az_client_id
    client_secret = var.az_client_secret
    subscription_id = var.az_subscription_id
  }
}

module "cluster" "icap"{
  source              = "../../rancher/cluster"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = local.service_name
  azure_region        = var.region
}

module "cluster_node_template" "icap_master"{
  source              = "../../rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = local.service_name
  node_image          = var.node_image
  node_type           = var.node_type
  node_disk_size      = "120"
  node_ports          = var.node_ports
  node_storage_type   = var.node_storage_type
  node_size           = "Standard_D1_v2"
  resource_group      = module.cluster.resource_group
  credential_name     = var.azure_sp_credential_name
  azure_region        = var.region
  cluster_virtual_machine_net = local.service_name
  cluster_subnet_name         = "${local.service_name}-sb-1"
  cluster_subnet_prefix       = ["10.20.2.0/24"]
}

module "cluster_node_template" "icap_worker"{
  source              = "../../rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = local.service_name
  node_image          = var.node_image
  node_type           = var.node_type
  node_disk_size      = "120"
  node_ports          = var.node_ports
  node_storage_type   = var.node_storage_type
  node_size           = "Standard_D2_v2"
  resource_group      = module.cluster.resource_group
  credential_name     = var.azure_sp_credential_name
  azure_region        = var.region
}


module "cluster_node_pool" "icap_master"{
  source                   = "../../rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = local.service_name
  cluster_id               = module.cluster.icap.id
  node_pool_template_id    = module.node_template.icap_master.id
  node_pool_nodes_qty      = 1
  control_plane            = true
  etcd                     = true
  worker                   = false
}

module "cluster_node_pool" "icap_worker"{
  source                   = "../../rancher/node_pool"
  rancher_admin_url        = var.rancher_admin_url
  rancher_admin_token      = var.rancher_admin_token
  service_name             = var.service_name
  cluster_id               = module.cluster.icap.id
  node_pool_template_id    = module.node_template.icap_master.id
  node_pool_nodes_qty      = 1
  control_plane            = true
  etcd                     = true
  worker                   = true
}