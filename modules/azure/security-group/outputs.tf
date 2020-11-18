
output "id" {
  value = azurerm_network_security_group.main.id
}

output "rule_id" {
  value = azurerm_network_security_group_rule.main.id
}