output "tls_private_key" {
  value = module.rancher_server.tls_private_key
}

output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "rancher_admin_token" {
  value = module.rancher_server.admin_token
}

output "rancher_api_url" {
  value = module.rancher_server.rancher_api_url
}

output "rancher_token_id" {
  value = module.rancher_server.admin_token_id
}

output "rancher_user" {
  value = module.rancher_server.admin_user
}

output "rancher_password" {
  value = module.rancher_server.admin_password
}

output "resource_group" {
  value = module.rancher_server.rancher_resource_group
}

output "network" {
  value = module.rancher_server.rancher_network
}
output "network_id" {
  value = module.rancher_server.network_id
}