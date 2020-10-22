provider "azurerm" {
  version = "=2.30.0"
  features {}
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "rancher-bootbstrap-terraform.tfstate"
  }
}

data "terraform_remote_state" "icap_service" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "glasswall-terraform.tfstate"
  }
}

locals {
    rancher_network         = data.terraform_remote_state.rancher_server.outputs.network
    rancher_network_id      = data.terraform_remote_state.rancher_server.outputs.network_id
    rancher_resource_group  = data.terraform_remote_state.rancher_server.outputs.resource_group
    icap_network            = data.terraform_remote_state.icap_service.outputs.network
    icap_network_id         = data.terraform_remote_state.icap_service.outputs.network_id
    icap_resource_group     = data.terraform_remote_state.icap_service.outputs.resource_group
}

resource "azurerm_virtual_network_peering" "rancher_server" {
  name                      = "peerRanchertoICAP"
  resource_group_name       = local.rancher_resource_group
  virtual_network_name      = local.rancher_network
  remote_virtual_network_id = local.icap_network_id
}

resource "azurerm_virtual_network_peering" "icap_cluster" {
  name                      = "peerICAPtoRancher"
  resource_group_name       = local.icap_resource_group
  virtual_network_name      = local.icap_network
  remote_virtual_network_id = local.rancher_network_id
}
