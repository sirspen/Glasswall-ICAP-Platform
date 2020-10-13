locals {
  service_name = "icap-p1-dev"
}

module "glasswall_icap" {
  source                  = "./modules/glasswall/icap"
  organisation            = "gw"
  project                 = "icap"
  environment             = "dev"
  suffix                  = "1"
  azure_region            = "ukwest"
  custom_data_file_path   = filebase64("scripts/start-rancher-server.sh")
}

data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}

resource "azurerm_dns_a_record" "rancher_server" {
  name                = "rancher-${local.service_name}"
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.glasswall_icap.linux_vm_public_ips]
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [module.glasswall_icap]

  create_duration = "300s"
}
