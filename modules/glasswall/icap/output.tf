output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "tls_private_key" {
  value = tls_private_key.ssh.private_key_pem
}

output "tls_public_key" {
  value = tls_private_key.ssh.public_key_openssh
}