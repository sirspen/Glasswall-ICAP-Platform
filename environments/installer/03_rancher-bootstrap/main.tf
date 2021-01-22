terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
  }
}

module "rancher_server" {
  source                 = "../../../workspace/rancher-bootstrap"
  organisation           = ""
  environment            = ""
  project                = "rancher-server"
  suffix                 = "a1"
  git_server_version     = "1.86"
  key_vault_resource_group = ""
  key_vault_name           = ""
  azure_region           = "" # ukwest
  dns_zone_name          = "" # environment.thedomainprefix
  tenant_id              = ""
  subscription_id        = ""
}