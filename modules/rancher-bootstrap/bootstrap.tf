
data "azurerm_dns_zone" "curlywurly_zone" {
  name                = "icap-proxy.curlywurly.me"
  resource_group_name = "gw-icap-rg-dns"
}

provider "rancher2" {
  alias = "bootstrap"
  api_url   = "https://rancher-${local.service_name}.${data.azurerm_dns_zone.curlywurly_zone.name}"
  bootstrap = true
  insecure = true # FIXME: Box should use proper cert
  retries = 100
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [module.rancher_server]
  create_duration = "300s"
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  depends_on = [time_sleep.wait_300_seconds]
}
