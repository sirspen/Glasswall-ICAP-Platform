
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-main-terraform.tfstate"
  }
}

module "rancher_server" {
  source                 = "../../../workspace/rancher-bootstrap"
  organisation           = "gw"
  environment            = "prd"
  project                = "rancher-server"
  suffix                 = "a1"
  git_server_version     = "1.87"
  dns_zone_name          = "prd.icap-proxy.curlywurly.me"
}