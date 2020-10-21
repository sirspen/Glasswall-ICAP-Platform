provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
  tenant_id       = "7049e6a3-141d-463a-836b-1ba40d3ff653"
}

locals {
  short_region    = substr(var.azure_region, 0, 3)
  service_name    = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
  rancher_api_url = "https://${data.terraform_remote_state.rancher_server.outputs.rancher_api_url}"
  storage_account_name = "gwtfstatestorageaccount"
  container_name       = "tfstatecontainer"
  key                  = "terraform.tfstate"
}

terraform {
  backend "gw-icap-tf-remote-store" {
    resource_group_name  = "gw-icap-rg-tfstate"
    storage_account_name = local.storage_account_name
    container_name       = local.container_name
    key                  = local.key
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "gw-icap-tf-remote-store"
  config = {
    storage_account_name = local.storage_account_name
    container_name       = local.container_name
    key                  = local.key
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
  source              = "./icap"
  rancher_admin_url   = local.rancher_api_url
  rancher_admin_token = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  service_name        = local.service_name
  suffix              = var.suffix
  client_id           = data.azurerm_key_vault_secret.az-client-id.id
  client_secret       = data.azurerm_key_vault_secret.az-client-secret.id
  subscription_id     = data.azurerm_key_vault_secret.az-subscription-id.id
  azure_region        = var.azure_region
}

