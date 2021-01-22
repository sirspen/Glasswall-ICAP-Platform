locals {
  service_name             = "${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
  store_name               = "${var.organisation}${var.project}${var.environment}${var.suffix}"
  kv_name                  = "${var.organisation}keyvault${var.environment}${var.suffix}"
  backend_rancher_server   = "${var.organisation}-rancherserver-${var.environment}-${var.suffix}.tfstate"
  backend_rancher_cluster  = "${var.organisation}-rancherclusters-${var.environment}-${var.suffix}.tfstate"
  backend_container_registry = "${var.organisation}-containerregistry-${var.environment}-${var.suffix}.tfstate"
}

module "storage" {
  source                   = "../../modules/azure/storage"
  location                 = var.azure_region
  resource_group_name      = local.service_name
  storage_account_name     = local.store_name
  storage_container_name   = "${local.service_name}-state-storage"
  account_tier             = var.storage_tier
  account_replication_type = var.replication_type
}

module "key_vault_storage" {
  source                   = "../../modules/azure/key-vault"
  service_name             = local.kv_name
  azure_region             = var.azure_region
}
