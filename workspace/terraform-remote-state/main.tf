locals {
  service_name             = "${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
}

module "storage" {
  source                   = "../../modules/azure/storage"
  location                 = var.azure_region
  resource_group_name      = "${local.service_name}"
  storage_account_name     = "${local.service_name}-sa"
  storage_container_name   = "${local.service_name}-state-storage"
  account_tier             = var.storage_tier
  account_replication_type = var.replication_type
}
