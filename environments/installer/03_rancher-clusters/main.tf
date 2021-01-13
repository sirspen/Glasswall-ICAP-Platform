
data "terraform_remote_state" "tfstate" {
  backend = "local"
  config = {
    path = "${path.module}/../terraform-remote-state/terraform.tfstate"
  }
}

locals {
  storage_container_name      = data.terraform_remote_state.rancher_server.outputs.storage_container_name
  storage_resource_group      = data.terraform_remote_state.rancher_server.outputs.storage_resource_group
  storage_account_name        = data.terraform_remote_state.rancher_server.outputs.storage_account_name
  storage_access_key          = data.terraform_remote_state.rancher_server.outputs.storage_access_key
}

terraform {
  backend "azurerm" {
    resource_group_name  = local.resource_group_name
    storage_account_name = local.storage_account_name
    container_name       = local.storage_container_name
    key                  = "abc-rancher-clusters-main-terraform.tfstate"
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = local.resource_group_name
    storage_account_name = local.storage_account_name
    container_name       = local.storage_container_name
    key                  = ""
  }
}
/*
"${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
*/
module "rancher_clusters" {
    source                                     = "../../../workspace/icap-multi-cluster-no-vault"
    organisation                               = ""
    environment                                = ""
    branch                                     = "main"
    dns_zone                                   = "" # needs to be an existing azure dns zone
    #cluster quantity is 1 per region
    icap_cluster_quantity                      = 1
    icap_master_scaleset_sku_capacity          = 1
    icap_worker_scaleset_sku_capacity          = 1
    subscription_id                            = ""
    tenant_id                                  = ""
    client_id                                  = ""
    client_secret                              = ""
}