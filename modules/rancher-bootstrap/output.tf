output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "tls_private_key" {
  value = tls_private_key.ssh.private_key_pem
}

output "tls_public_key" {
  value = tls_private_key.ssh.public_key_openssh
}

output "admin_user" {
  value = rancher2_bootstrap.admin.user
}

output "admin_password" {
  value = random_password.password.result
}

output "admin_url" {
  value = rancher2_bootstrap.admin.url
}

output "admin_token" {
  value = rancher2_bootstrap.admin.token
}

output "admin_token_id" {
  value = rancher2_bootstrap.admin.token_id
}

output "rancher_api_url" {
  value = azurerm_dns_a_record.rancher_server.fqdn
}