output "linux_vm_private_ips" {
  value = azurerm_linux_virtual_machine.the_machine.private_ip_address
}

output "linux_vm_public_ips" {
  value = azurerm_linux_virtual_machine.the_machine.public_ip_address
}

