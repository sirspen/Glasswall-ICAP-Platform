provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
  tenant_id       = "7049e6a3-141d-463a-836b-1ba40d3ff653"
}

data "terraform_remote_state" "rancher_server" {
  backend = "local"
  config = {
    path = "../../terraform.tfstate"
  }
}

locals {
  short_region    = substr(var.azure_region, 0, 3)
  service_name    = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
  rancher_api_url = "https://${data.terraform_remote_state.rancher_server.outputs.rancher_api_url}"
}

data "azurerm_key_vault_client_id" "az-client-id" {
  name      = "az-client-id"
  vault_uri = "https://gw-icap-keyvault.vault.azure.net/secrets/az-client-id/4bdda12cb6fc4dc7a9d60bf75de34ec1"
}

data "azurerm_key_vault_client_secret" "az-client-secret" {
  name      = "az-client-secret"
  vault_uri = "https://gw-icap-keyvault.vault.azure.net/secrets/az-client-secret/1b491e39e77d4da68c12d9554e4e77a2"
}

data "azurerm_key_vault_subscription_id" "az-subscription-id" {
  name      = "subscription-id"
  vault_uri = "https://gw-icap-keyvault.vault.azure.net/secrets/az-subscription-id/7c38dd2274304bae9a2a23f76baa5ed8"
}

module "icap_service" {
  source              = "./icap"
  rancher_admin_url   = local.rancher_api_url
  rancher_admin_token = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  service_name        = local.service_name
  suffix              = var.suffix
  client_id           = data.azurerm_key_vault_client_id.az-client-id.id
  client_secret       = data.azurerm_key_vault_client_secret.az-client-secret.id
  subscription_id     = data.azurerm_key_vault_subscription_id.az-subscription-id.id
  azure_region        = var.azure_region
}

