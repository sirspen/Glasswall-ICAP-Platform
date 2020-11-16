terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-icap-cluster-terraform.tfstate"
  }
}

locals {
  service_name             = "${var.organisation}-${var.project}-${var.environment}"
  rancher_admin_url        = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
  rancher_internal_api_url = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
  rancher_network          = data.terraform_remote_state.rancher_server.outputs.network
  rancher_server_url       = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
  rancher_admin_token      = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network_id       = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group   = data.terraform_remote_state.rancher_server.outputs.resource_group
  public_key_openssh       = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
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

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "icap_cluster_c1" {
  source                       = "../../modules/gw/cluster"
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_admin_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  suffix                       = "c1"
  azure_region                 = "northeurope"
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  cluster_backend_port         = var.backend_port
  cluster_public_port          = var.public_port
  cluster_address_space        = ["172.16.0.0/12", "192.168.0.0/16"]
  cluster_subnet_cidr          = ["172.30.0.0/16"]
  cluster_subnet_prefix        = "172.30.2.0/24"
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  master_scaleset_size         = "Standard_DS2_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 3
  worker_scaleset_size         = "Standard_DS2_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 3
}

module "icap_cluster_c2" {
  source                       = "../../modules/gw/cluster"
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_admin_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  suffix                       = "c2"
  azure_region                 = "ukwest"
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  cluster_backend_port         = var.backend_port
  cluster_public_port          = var.public_port
  cluster_address_space        = ["172.32.0.0/12", "192.168.0.0/16"]
  cluster_subnet_cidr          = ["172.46.0.0/16"]
  cluster_subnet_prefix        = "172.46.2.0/24"
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  master_scaleset_size         = "Standard_DS2_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 3
  worker_scaleset_size         = "Standard_DS2_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 3
}