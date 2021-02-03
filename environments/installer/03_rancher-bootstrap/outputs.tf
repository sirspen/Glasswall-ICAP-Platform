output "tls_private_key" {
  value = module.rancher_server.tls_private_key
}

output "public_key_openssh" {
  value = module.rancher_server.public_key_openssh
}

output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "git_server_public_ips" {
  value = module.rancher_server.git_server_public_ips
}

output "linux_vm_private_ips" {
  value = module.rancher_server.linux_vm_private_ips
}

output "git_server_url" {
  value = module.rancher_server.git_server_url
}

output "rancher_admin_token" {
  value = module.rancher_server.rancher_admin_token
}

output "rancher_api_url" {
  value = module.rancher_server.rancher_api_url
}

output "rancher_internal_api_url" {
  value = module.rancher_server.rancher_internal_api_url
}

output "rancher_internal_server_url" {
  value = module.rancher_server.rancher_internal_server_url
}

output "rancher_server_url" {
  value = module.rancher_server.rancher_server_url
}

output "rancher_token_id" {
  value = module.rancher_server.rancher_token_id
}

output "rancher_user" {
  value = module.rancher_server.rancher_user
}

output "rancher_password" {
  value = module.rancher_server.rancher_password
}

output "resource_group" {
  value = module.rancher_server.resource_group
}

output "region" {
  value = module.rancher_server.region
}

output "network" {
  value = module.rancher_server.network
}

output "network_id" {
  value = module.rancher_server.network_id
}

output "subnet_name" {
  value = module.rancher_server.subnet_name
}

output "subnet_id" {
  value = module.rancher_server.subnet_id
}

output "rancher_suffix" {
  value = module.rancher_server.rancher_suffix
}

output "subnet_prefix" {
  value = module.rancher_server.subnet_prefix
}

output "rancher_server_version" {
  value = module.rancher_server.rancher_server_version
}

output "rancher_agent_version" {
  value = module.rancher_server.rancher_agent_version
}