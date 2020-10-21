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
    key                  = "rancher-bootbstrap-terraform.tfstate"
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
  organisation           = var.organisation
  environment            = var.environment
  rancher_admin_url      = local.rancher_api_url
  rancher_admin_token    = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network        = data.terraform_remote_state.rancher_server.outputs.rancher_network
  rancher_resource_group = data.terraform_remote_state.rancher_server.outputs.rancher_resource_group
  service_name           = local.service_name
  suffix                 = var.suffix
  tenant_id              = var.tenant_id
  client_id              = data.azurerm_key_vault_secret.az-client-id.id
  client_secret          = data.azurerm_key_vault_secret.az-client-secret.id
  subscription_id        = data.azurerm_key_vault_secret.az-subscription-id.id
  azure_region           = var.azure_region
  address_space          = ["172.20.0.0/16"]
  subnet_cidr            = ["172.20.2.0/24"]
  cluster_subnet_prefix  = "172.20.2.0/24"
}
