
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-develop-terraform.tfstate"
  }
}

module "rancher_server" {
  source                 = "../../../workspace/rancher-bootstrap"
  organisation           = "gw"
  environment            = "dev"
  project                = "rancher-server"
  suffix                 = "z1"
  git_server_version     = "2.12"
  azure_region           = "ukwest" # ukwest
  dns_zone_name          = "dev.icap-proxy.curlywurly.me"
  subscription_id        = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
  tenant_id              = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  key_vault_resource_group = "keyvault"
  key_vault_name           = "gw-icap-keyvault"
}