
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
  git_server_version     = "1.94"
  azure_region           = "ukwest" # ukwest
  dns_zone_name          = "prd.icap-proxy.curlywurly.me"
  key_vault_resource_group = "keyvault"
  key_vault_name           = "gw-icap-keyvault"
  #tenant_id              = "" in tfvars now
  #subscription_id        = "" in tfvars now
}