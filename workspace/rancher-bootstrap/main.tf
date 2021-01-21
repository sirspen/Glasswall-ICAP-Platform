locals {
  project      = "${var.project}-${var.suffix}"
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${local.project}-${var.environment}-${local.short_region}"
}

module "rancher_server" {
  source                = "../../modules/rancher-bootstrap"
  organisation          = var.organisation
  project               = var.project
  environment           = var.environment
  suffix                = var.suffix
  dns_zone              = var.dns_zone_name
  azure_region          = var.azure_region
  rancher_server_version=var.rancher_server_version
  git_server_version    = var.git_server_version
  size                  = var.size
  key_vault_resource_group = var.key_vault_resource_group
  key_vault_name           = var.key_vault_name
}
