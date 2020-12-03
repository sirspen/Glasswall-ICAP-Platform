data "terraform_remote_state" "rancher_bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-protocluster-develop-terraform.tfstate"
    //TODO check rancher bootstrap key
  }
}

data "terraform_remote_state" "cluster" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-protocluster-develop-terraform.tfstate"
    //TODO check cluster key
  }
}

//module "adaptation" {
//  source                  = "../../modules/gw/adaptation-components"
//  rancher_admin_url       = local.rancher_api_url
//  rancher_admin_token     = local.rancher_admin_token
//  catalogue_name = module.catalog.catalogue_name
//  providers = {
//    rancher2.adm = rancher2.admin
//  }
//  project_ids = [rancher2_project.icap-service.id]
//  system_project_ids = [data.rancher2_project.system.id]
//}