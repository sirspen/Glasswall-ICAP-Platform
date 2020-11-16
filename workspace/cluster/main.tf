terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-icap-cluster-terraform.tfstate"
  }
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

locals {
  short_region             = substr(var.azure_region, 0, 3)
  service_name             = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
  rancher_api_url          = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
  rancher_internal_api_url = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
  rancher_network          = data.terraform_remote_state.rancher_server.outputs.network
  rancher_server_url       = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
  rancher_admin_token      = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network_id       = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group   = data.terraform_remote_state.rancher_server.outputs.resource_group  public_key_openssh      = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
}

data "terraform_remote_state" "rancher_server" {
  backend                = "azurerm"
  config                 = {
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

module "icap_infra" {
  source                       = "../../../modules/gw/icap-infra"

}

module "icap_service" {
  source                       = "./icap"
  cluster_resource_group       = module.icap_infra.resource_group_name
  cluster_virtual_network_name = module.icap_infra.network_name
  cluster_subnet_name          = module.icap_infra.subnet_name
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_url            = local.rancher_api_url
  service_name                 = local.service_name
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  organisation                 = var.organisation
  environment                  = var.environment
  suffix                       = "c1"
  tenant_id                    = var.tenant_id
  azure_region                 = var.azure_region
  os_version                   = "latest"
  os_sku                       = "7-LVM"
  os_offer                     = "RHEL"
  os_publisher                 = "RedHat"
  cluster_subnet_id            = module.subnet.id
  cluster_subnet_prefix        = "172.30.2.0/24"
  worker_lb_id                 = module.worker_lb.id
  worker_lb_bap_id             = azurerm_lb_backend_address_pool.lb_bap_1.id
  worker_lb_probe_id           = azurerm_lb_probe.ingress_probe_1.id
  worker_scaleset_size         = "Standard_DS2_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 3
}
