
output "name" {
  value = azurerm_virtual_machine_scale_set.cluster_scaleset_lb.*.name
}

output "id" {
  value = azurerm_virtual_machine_scale_set.cluster_scaleset_lb.*.id
}

output "no_lbname" {
  value = azurerm_virtual_machine_scale_set.cluster_scaleset_nolb.*.name
}

output "no_lbid" {
  value = azurerm_virtual_machine_scale_set.cluster_scaleset_nolb.*.id
}
