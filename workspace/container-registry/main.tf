locals {
  service_name             = "${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
  store_name               = "${var.organisation}${var.project}${var.environment}${var.suffix}"
}

module "registry" {
  source                   = "../../modules/azure/container-registry"
  location                 = var.azure_region
  service_name             = local.store_name 
  resource_group_name      = local.service_name
}