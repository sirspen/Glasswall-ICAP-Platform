/*terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-icap-protomulticluster-develop-terraform.tfstate"
  }
}*/

locals {
  short_region_r1          = substr(var.azure_region_r1, 0, 3)
  short_region_r2          = substr(var.azure_region_r2, 0, 3)
  service_name             = "${var.organisation}-${var.project}-${var.environment}"
  admin_service_name       = "${var.organisation}-${var.project}-admin-${var.environment}"
  service_name_nodash_r1   = "${var.organisation}icap${var.environment}${local.short_region_r1}"
  service_name_nodash_r2   = "${var.organisation}icap${var.environment}${local.short_region_r2}"
  rancher_api_url          = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
  rancher_internal_api_url = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
  rancher_network          = data.terraform_remote_state.rancher_server.outputs.network
  rancher_server_url       = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
  rancher_admin_token      = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network_name     = data.terraform_remote_state.rancher_server.outputs.network
  rancher_network_id       = data.terraform_remote_state.rancher_server.outputs.network_id
  rancher_resource_group   = data.terraform_remote_state.rancher_server.outputs.resource_group
  rancher_subnet_id        = data.terraform_remote_state.rancher_server.outputs.subnet_id
  rancher_subnet_name      = data.terraform_remote_state.rancher_server.outputs.subnet_name
  rancher_region           = data.terraform_remote_state.rancher_server.outputs.region
  git_server_url           = data.terraform_remote_state.rancher_server.outputs.git_server_url
  public_key_openssh       = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
  cluster_catalogs    = {
    icap-catalog = {
      helm_charts_repo_url = "${local.git_server_url}/icap-infrastructure.git"
      helm_charts_repo_branch = "add-image-registry"
    }
  }
  azure_icap_clusters      = {
    northeurope = {
      suffix                       = "z"
      cluster_quantity             = 1
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
      master_scaleset_sku_capacity = 1
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = 2
      rancher_projects             = "icapservice"
      icap_internal_services       = var.icap_internal_services
  },
  ukwest = {
      suffix                       = "y"
      cluster_quantity             = 1
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
      master_scaleset_sku_capacity = 1
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = 2
      rancher_projects             =  "icapservice"
      icap_internal_services       = var.icap_internal_services
    }
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-${var.branch}-terraform.tfstate"
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


module "catalog" {
    source                  = "../../modules/rancher/catalogue"
    for_each                = local.cluster_catalogs
    name                    = each.key
    helm_charts_repo_url    = each.value.helm_charts_repo_url
    helm_charts_repo_branch = each.value.helm_charts_repo_branch
}

module "icap_clusters" {
  source                       = "../../modules/gw/cluster"
  for_each                     = local.azure_icap_clusters
  cluster_quantity             = each.value.cluster_quantity
  suffix                       = each.value.suffix
  azure_region                 = each.value.azure_region
  rancher_projects             = each.value.rancher_projects
  cluster_backend_port         = each.value.cluster_backend_port
  cluster_public_port          = each.value.cluster_public_port
  cluster_address_space        = each.value.cluster_address_space
  cluster_subnet_cidr          = each.value.cluster_subnet_cidr
  cluster_subnet_prefix        = each.value.cluster_subnet_prefix
  cluster_internal_services    = each.value.icap_internal_services
  os_publisher                 = each.value.os_publisher
  os_offer                     = each.value.os_offer
  os_sku                       = each.value.os_sku
  os_version                   = each.value.os_version
  master_scaleset_size         = each.value.master_scaleset_size
  master_scaleset_admin_user   = each.value.master_scaleset_admin_user
  master_scaleset_sku_capacity = each.value.master_scaleset_sku_capacity
  worker_scaleset_size         = each.value.master_scaleset_size
  worker_scaleset_admin_user   = each.value.master_scaleset_admin_user
  worker_scaleset_sku_capacity = each.value.master_scaleset_sku_capacity
  organisation                 = var.organisation
  environment                  = var.environment
  cluster_apps                 = var.icap_cluster_apps
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_resource_group       = local.rancher_resource_group
  service_name                 = local.service_name
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  public_key_openssh           = local.public_key_openssh
  rancher_network_id           = local.rancher_network_id
}


module "admin_cluster" {
  source                       = "../../modules/gw/standalone-cluster"
  organisation                 = var.organisation
  environment                  = var.environment
  rancher_admin_url            = local.rancher_api_url
  rancher_internal_api_url     = local.rancher_internal_api_url
  rancher_admin_token          = local.rancher_admin_token
  rancher_network              = local.rancher_network
  rancher_network_id           = local.rancher_network_id
  # we may not want to always reuse the same resource_group.
  rancher_resource_group       = local.rancher_resource_group
  cluster_resource_group_name  = local.rancher_resource_group
  cluster_network_name         = local.rancher_network_name
  cluster_subnet_name          = local.rancher_subnet_name
  cluster_subnet_id            = local.rancher_subnet_id
  service_name                 = local.admin_service_name
  suffix                       = "a"
  azure_region                 = local.rancher_region
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  public_key_openssh           = local.public_key_openssh
  os_publisher                 = var.os_publisher
  os_offer                     = var.os_offer
  os_sku                       = var.os_sku
  os_version                   = var.os_version
  rancher_projects             = "adminservice"
  cluster_backend_port         = 32323 #var.cluster_backend_port
  cluster_public_port          = 443 #var.cluster_public_port
  #cluster_address_space        = var.cluster_address_space
  #cluster_subnet_cidr          = var.cluster_subnet_cidr
  #cluster_subnet_prefix        = var.cluster_subnet_prefix
  cluster_apps                 = var.admin_cluster_apps
  master_scaleset_size         = "Standard_DS4_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 1
  worker_scaleset_size         = "Standard_DS4_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 1
}
