/*output "linux_vm_private_ips" {
  value = resource.azurerm_linux_virtual_machine.private_ip_address
}

output "linux_vm_public_ips" {
  value = resource.azurerm_linux_virtual_machine.public_ip_address
}*/

output "tls_private_key" {
  value = tls_private_key.machine_ssh.private_key_pem
}