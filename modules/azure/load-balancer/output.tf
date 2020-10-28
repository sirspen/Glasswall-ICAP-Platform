output "id" {
  value = azurerm_lb.lb.id
}

output "probe_id" {
  value = azurerm_lb_probe.lb_probe.id
}

output "bap_id" {
  value = azurerm_lb_probe.lb_bap.id
}