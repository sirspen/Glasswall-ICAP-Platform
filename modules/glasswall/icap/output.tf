output "tls_private_key" {
  value = module.azure_virtual_machine.tls_private_key
}

output "linux_vm_public_ips" {
  value = module.azure_virtual_machine.linux_vm_public_ips
}