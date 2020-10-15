
resource "rancher2_cloud_credential" "cluster_credentials" {
  name = "Azure Credentials"
  azure_credential_config {
    client_id = var.az_client_id
    client_secret = var.az_client_secret
    subscription_id = var.az_subscription_id
  }
}






module "cluster_node_template" "master_node_template"{
  source              = "../../rancher/node_template"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  service_name        = var.service_name
  node_image          = var.node_image
  node_type           = var.node_type
  node_disk_size      = var.node_disk_size
  node_ports          = var.node_ports
  node_storage_type   = var.node_storage_type
  node_size           = var.node_size
  resource_group      = var.resource_group
  credential_name     = var.azure_sp_credential_name
  azure_region        = var.azure_region
}

module "cluster_node_template" "worker_node_template"{
  source              = "../../rancher/node_template"

}

module "cluster_node_pool" "master_node_pool"{
  source              = "../../rancher/node_pool"

}

module "cluster_node_pool" "worker_node_pool"{
  source              = "../../rancher/node_pool"

}
module "cluster" "icap_cluster"{
  source              = "../../rancher/cluster"

}