
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
  name            = local.service_name
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

module "rancher_server" {
  source                  = "../azure/vm"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  service_name            = local.service_name
  service_type            = "rancher_server"
  os_sku                  = "7-LVM"
  os_offer                = "RHEL"
  os_publisher            = "RedHat"
  region                  = var.azure_region
  custom_data_file_path   = var.custom_data_file_path
  subnet_id               = module.subnet.id
  public_ip_id            = module.public_ip.id
  public_key_openssh      = tls_private_key.ssh.public_key_openssh
}

resource "azurerm_dns_a_record" "rancher_server" {
  name                = "rancher-${local.service_name}"
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.rancher_server.linux_vm_public_ips]
}


#module "rancher_nodes" {
#  source                  = "../../azure/vm"
#  organisation            = var.organisation
#  environment             = var.environment
#  project                 = local.project
#  type                    = "worker"
#  os_sku                  = "7-LVM"
#  os_offer                = "RHEL"
#  os_publisher            = "RedHat"
#  azure_region            = "ukwest"
#  custom_data_file_path   = var.custom_data_file_path_worker
#  network_cidr_range      = ["10.10.0.0/16"]
#  network_subnet_prefixes = ["10.10.2.0/24"]
#  network_subnet_names    = ["subnet-1"]
#}
