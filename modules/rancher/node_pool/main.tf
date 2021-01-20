
# Azure Node Pool
resource "rancher2_node_pool" "node_pool" {
  provider              = rancher2
  cluster_id            = var.cluster_id
  name                  = var.service_name
  hostname_prefix       = var.service_name
  node_template_id      = var.node_pool_template_id
  quantity              = var.node_pool_nodes_qty
  control_plane         = var.node_pool_role_control_plane
  etcd                  = var.node_pool_role_etcd
  worker                = var.node_pool_role_worker
  labels                = var.labels

  dynamic "node_taints" {
    for_each = var.node_taints
    content {
      key = node_taints.value["key"]
      value = node_taints.value["value"]
      effect = node_taints.value["effect"]
    }
  }
}

resource "random_id" "node_pool" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group      = var.resource_group
  }
  byte_length           = 8
}