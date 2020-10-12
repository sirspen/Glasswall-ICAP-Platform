provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://${module.glasswall_icap.linux_vm_public_ips}"
  bootstrap = true
  insecure = true # FIXME: Box should use proper cert
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  timeouts {
    create = "10m"
  }
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
