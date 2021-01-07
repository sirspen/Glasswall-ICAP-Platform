locals {
  service_name             = "${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
}

module "container-registry" {
  source                   = "../../modules/azure/container-registry"
  location                 = var.location
  resource_group_name      = "${local.service_name}-rg"
}