provider "azurerm" {
  version = "=2.30.0"
  tenant_id = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  features {}
}

locals {
  project = "${var.project}-${var.suffix}"
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${local.project}-${var.environment}-${local.short_region}"
}

module "rancher_server" {
  source                  = "./modules/rancher-bootstrap"
  organisation            = var.organisation
  project                 = var.project
  environment             = var.environment
  suffix                  = var.suffix
  azure_region            = var.azure_region
  custom_data_file_path   = filebase64("scripts/start-rancher-server.sh")
}