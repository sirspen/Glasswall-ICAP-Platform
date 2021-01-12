locals {
  project      = "${var.project}-${var.suffix}"
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${local.project}-${var.environment}-${local.short_region}"
}
/*
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-develop-terraform.tfstate"
  }
}*/

module "rancher_server" {
  source                = "../../modules/rancher-bootstrap"
  organisation          = var.organisation
  project               = var.project
  environment           = var.environment
  suffix                = var.suffix
  dns_zone              = var.dns_zone_name
  azure_region          = var.azure_region
  custom_data_file_path = filebase64("${path.module}/scripts/cloud-init.yaml")
  git_server_version    = var.git_server_version
  size                  = var.size
}