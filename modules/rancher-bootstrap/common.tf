provider "azurerm" {
  features {}
}

locals {
  project = "${var.project}-${var.suffix}"
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${local.project}-${var.environment}-${local.short_region}"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "resource_group" {
  source                  = "../azure/resource_group"
  name                    = local.service_name
  region                  = var.azure_region
}

module "network" {
  source                  = "../azure/network"
  resource_group          = module.resource_group.name
  region                  = var.azure_region
  service_name            = local.service_name
  address_space           = ["10.10.0.0/16"]
  organisation            = var.organisation
  environment             = var.environment
}

module "subnet" {
  source                  = "../azure/subnet"
  service_name            = local.service_name
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  address_prefixes        = ["10.10.2.0/24"]
}

module "public_ip" {
  source                  = "../azure/public_ip"
  resource_group          = module.resource_group.name
  region                  = var.azure_region
  service_name            = local.service_name
  service_type            = "rancher_server"
  organisation            = var.organisation
  environment             = var.environment
}

data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}