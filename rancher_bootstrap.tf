provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://rancher-${local.service_name}.${data.azurerm_dns_zone.curlywurly_zone.name}"
  bootstrap = true
  insecure = true # FIXME: Box should use proper cert
  retries = 100
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  depends_on = [time_sleep.wait_300_seconds]
}

output "token" {
  value = rancher2_bootstrap.admin.token
}

output "token_id" {
  value = rancher2_bootstrap.admin.token_id
}

output "password" {
  value = rancher2_bootstrap.admin.password
}
