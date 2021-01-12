
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-clusters-develop-terraform.tfstate"
  }
}

module "rancher_clusters" {
    source              = "../../../workspace/proto-multi-clusters"
    organisation        = "gw"
    environment         = "dev"
    branch              = "develop"
    subscription_id     = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
    tenant_id           = "7049e6a3-141d-463a-836b-1ba40d3ff653"
    #cluster quantity is 1 per region
    icap_cluster_quantity  = 1
    icap_master_scaleset_sku_capacity = 1
    icap_worker_scaleset_sku_capacity = 1
    dns_zone = "dev.icap-proxy.curlywurly.me"
}
