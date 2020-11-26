terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-icap-protomulticluster-develop-terraform.tfstate"
  }
}

locals {
  short_region_r1          = substr(var.azure_region_r1, 0, 3)
  short_region_r2          = substr(var.azure_region_r2, 0, 3)
  service_name             = "${var.organisation}-${var.project}-${var.environment}"
  service_name_nodash_r1   = "${var.organisation}icap${var.environment}${local.short_region_r1}"
  service_name_nodash_r2   = "${var.organisation}icap${var.environment}${local.short_region_r2}"
  rancher_api_url          = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
  rancher_internal_api_url = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
  rancher_network          = data.terraform_remote_state.rancher_server.outputs.network
  rancher_server_url       = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
  rancher_admin_token      = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network_id       = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group   = data.terraform_remote_state.rancher_server.outputs.resource_group
  rancher_subnet_id        = data.terraform_remote_state.rancher_server.outputs.subnet_id
  rancher_subnet_name      = data.terraform_remote_state.rancher_server.outputs.subnet_name
  git_server_url           = data.terraform_remote_state.rancher_server.outputs.git_server_url
  public_key_openssh       = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
  azure_icap_clusters      = {
    northeurope = {
      suffix                       = "z"
      cluster_quantity             = 3
      azure_region                 = var.azure_region_r1
      cluster_backend_port         = var.backend_port
      cluster_public_port          = var.public_port
      cluster_address_space        = var.cluster_address_space_r1
      cluster_subnet_cidr          = var.cluster_subnet_cidr_r1
      cluster_subnet_prefix        = var.cluster_subnet_prefix_r1
      os_publisher                 = var.os_publisher
      os_offer                     = var.os_offer
      os_sku                       = var.os_sku
      os_version                   = var.os_version
      master_scaleset_size         = "Standard_DS4_v2"
      master_scaleset_admin_user   = "azure-user"
      master_scaleset_sku_capacity = 2
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = 2
      rancher_projects             = "icapservice"
  },
  ukwest = {
      suffix                       = "y"
      cluster_quantity             = 3
      azure_region                 = var.azure_region_r2
      cluster_backend_port         = var.backend_port
      cluster_public_port          = var.public_port
      cluster_address_space        = var.cluster_address_space_r2
      cluster_subnet_cidr          = var.cluster_subnet_cidr_r2
      cluster_subnet_prefix        = var.cluster_subnet_prefix_r2
      os_publisher                 = var.os_publisher
      os_offer                     = var.os_offer
      os_sku                       = var.os_sku
      os_version                   = var.os_version
      master_scaleset_size         = "Standard_DS4_v2"
      master_scaleset_admin_user   = "azure-user"
      master_scaleset_sku_capacity = 2
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = 2
      rancher_projects             =  "icapservice"
    }
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-protocluster-develop-terraform.tfstate"
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

module "icap_clusters" {
  source                       = "../../modules/gw/cluster"
  for_each                     = local.azure_icap_clusters
  cluster_quantity             = var.cluster_quantity
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  suffix                       = var.suffix
  azure_region                 = var.azure_region
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  cluster_backend_port         = var.backend_port
  cluster_public_port          = var.public_port
  cluster_address_space        = var.cluster_address_space
  cluster_subnet_cidr          = var.cluster_subnet_cidr
  cluster_subnet_prefix        = var.cluster_subnet_prefix
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  rancher_projects             = var.rancher_projects
  master_scaleset_size         = var.master_scaleset_size
  master_scaleset_admin_user   = var.master_scaleset_admin_user
  master_scaleset_sku_capacity = var.master_scaleset_sku_capacity
  worker_scaleset_size         = var.master_scaleset_size
  worker_scaleset_admin_user   = var.master_scaleset_admin_user
  worker_scaleset_sku_capacity = var.master_scaleset_sku_capacity
}
/*
module "admin_cluster" {
  source                       = "../../modules/gw/standalone-cluster"
  for_each                     = local.azure_icap_clusters
  cluster_quantity             = var.cluster_quantity
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  suffix                       = var.suffix
  azure_region                 = var.azure_region
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  rancher_projects             = var.rancher_projects
  master_scaleset_size         = var.master_scaleset_size
  master_scaleset_admin_user   = var.master_scaleset_admin_user
  master_scaleset_sku_capacity = var.master_scaleset_sku_capacity
  worker_scaleset_size         = var.master_scaleset_size
  worker_scaleset_admin_user   = var.master_scaleset_admin_user
  worker_scaleset_sku_capacity = var.master_scaleset_sku_capacity
}
*/