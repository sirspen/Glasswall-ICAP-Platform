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


module "icap_cluster" {
  source                    = "./modules/glasswall/icap"
  rancher_admin_url         = module.rancher_server.admin_url
  rancher_admin_token       = module.rancher_server.admin_token
  service_name              = local.service_name
  client_id                 = var.az_client_id
  client_secret             = var.az_client_secret
  subscription_id           = var.az_subscription_id
  azure_region              = var.azure_region
}
