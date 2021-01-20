
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
    organisation        = "gw"
    environment         = "prd"
    branch              = "main"
    icap_cluster_suffix_r1 = "b"
    icap_cluster_suffix_r2 = "c"
    icap_cluster_suffix_r3 = "d"
    icap_cluster_quantity  = 3
    icap_master_scaleset_sku_capacity = 1
    icap_worker_scaleset_sku_capacity = 1
    dns_zone = "prd.icap-proxy.curlywurly.me"
    tenant_id              = "7049e6a3-141d-463a-836b-1ba40d3ff653"
    subscription_id        = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
}
