data "terraform_remote_state" "rancher_server" {
  backend = "local"
  config = {
    path = "../rancher-bootstrap/terraform.tfstate"
  }
}

locals {
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
  rancher_api_url = "https://${data.terraform_remote_state.rancher_server.outputs.rancher_api_url}"
}

module "icap_service" {
  source                    = "./icap"
  organisation              = var.organisation
  environment               = var.environment
  rancher_admin_url         = local.rancher_api_url
  rancher_admin_token       = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
  rancher_network           = data.terraform_remote_state.rancher_server.outputs.rancher_network
  rancher_resource_group    = data.terraform_remote_state.rancher_server.outputs.rancher_resource_group
  service_name              = local.service_name
  suffix                    = var.suffix
  tenant_id                 = var.az_tenant_id
  client_id                 = var.az_client_id
  client_secret             = var.az_client_secret
  subscription_id           = var.az_subscription_id
  azure_region              = var.azure_region
  address_space             = ["172.20.0.0/16"]
  subnet_cidr               = ["172.20.2.0/24"]
  cluster_subnet_prefix     = "172.20.2.0/24"
}