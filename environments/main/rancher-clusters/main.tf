
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-clusters-main-terraform.tfstate"
  }
}

module "rancher_clusters" {
    source              = "../../../workspace/proto-multi-clusters"
    environment         = "prd"
    branch              = "main"
    icap_cluster_suffix_r1 = "b"
    icap_cluster_suffix_r2 = "c"
    icap_cluster_quantity  = 5
    icap_master_scaleset_sku_capacity = 1
    icap_worker_scaleset_sku_capacity = 2
}
