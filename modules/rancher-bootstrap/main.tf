
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

module "rancher_server" {
  source                  = "../azure/vm"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  service_name            = local.service_name
  size                    = "Standard_D2_v2"
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

data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}

resource "azurerm_dns_a_record" "rancher_server" {
  name                = local.service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.rancher_server.linux_vm_public_ips]
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [module.rancher_server]
  create_duration = "300s"
}

provider "rancher2" {
  alias = "bootstrap"
  #api_url = "https://${azurerm_dns_a_record.rancher_server.fqdn}"
  api_url   = "https://${local.service_name}.${data.azurerm_dns_zone.curlywurly_zone.name}"
  bootstrap = true
  insecure = true # FIXME: Box should use proper cert
  retries = 100
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  password = random_password.password.result
  depends_on = [time_sleep.wait_300_seconds]

  provisioner "remote-exec" {
    inline = [
      "cd ../rancher-bootstrap/src",
      "make example"
    ]
  }
}
