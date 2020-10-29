provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

locals {
  short_region    = substr(var.azure_region, 0, 3)
  service_name    = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
  rancher_api_url = "https://${data.terraform_remote_state.rancher_server.outputs.rancher_api_url}"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "glasswall-terraform.tfstate"
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "rancher-server-terraform.tfstate"
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = "gw-icap-keyvault"
  resource_group_name = "keyvault"
}

data "azurerm_key_vault_secret" "az-client-id" {
  name         = "az-client-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-client-secret" {
  name         = "az-client-secret"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-subscription-id" {
  name         = "az-subscription-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "icap_service" {
  source                 = "./icap"
  rancher_admin_token    = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network        = data.terraform_remote_state.rancher_server.outputs.network
  rancher_resource_group = data.terraform_remote_state.rancher_server.outputs.resource_group
  client_id              = data.azurerm_key_vault_secret.az-client-id.value
  client_secret          = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id        = data.azurerm_key_vault_secret.az-subscription-id.value
  rancher_admin_url      = local.rancher_api_url
  service_name           = local.service_name
  organisation           = var.organisation
  environment            = var.environment
  suffix                 = var.suffix
  tenant_id              = var.tenant_id
  azure_region           = var.azure_region
  node_custom_data       = file("../../scripts/cloud-init.yaml")
  address_space          = ["172.16.0.0/12","192.168.0.0/16"]
  subnet_cidr            = ["172.20.2.0/24"]
  cluster_subnet_prefix  = "172.20.2.0/24"
}
