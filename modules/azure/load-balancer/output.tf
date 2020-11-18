output "id" {
  value = azurerm_lb.lb.id
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}
#output "probe_id" {
##  value = azurerm_lb_probe.ingress_probe.id
#}