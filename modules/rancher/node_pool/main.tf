
/*provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}*/

# Azure Node Pool
resource "rancher2_node_pool" "node_pool" {
  cluster_id = var.cluster_id
  name = var.service_name
  hostname_prefix = "rke-${random_id.node_pool.hex}-"
  node_template_id = var.node_pool_template_id
  quantity = var.node_pool_nodes_qty
  control_plane = var.node_pool_role_control_plane
  etcd = var.node_pool_role_etcd
  worker = var.node_pool_role_worker
}

resource "random_id" "node_pool" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group
  }

  byte_length = 8
}