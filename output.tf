output "tls_private_key" {
  value = module.rancher_server.tls_private_key
}

output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "rancher_admin_token" {
  value = module.rancher_server.token
}

output "rancher_token_id" {
  value = module.rancher_server.token_id
}

output "rancher_password" {
  value = module.rancher_server.password
}
