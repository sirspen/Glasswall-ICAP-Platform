output "id" {
  value = azurerm_lb.lb.id
}

output "probe_id" {
  value = azurerm_lb_probe.ingress_probe.id
}

output "bap_id" {
  value = azurerm_lb_backend_address_pool.lb_bap.id
}