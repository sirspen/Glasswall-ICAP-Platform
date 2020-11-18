output "resource_group_name" {
  value = module.resource_group.name
}

output "network_name" {
  value = module.network.name
}

output "network_id" {
  value = module.network.id
}

output "subnet_name" {
  value = module.subnet.name
}

output "subnet_id" {
  value = module.subnet.id
}

output "worker_lb_id" {
  value = module.worker_lb.id   
}

output "worker_lbap_id" {
  value = azurerm_lb_backend_address_pool.worker_lbap.id
}

output "worker_ingress_probe_id" {
  value = azurerm_lb_probe.worker_ingress_probe.id
}

output "worker_ingress_rule_1_id" {
  value = azurerm_lb_rule.worker_ingress_rule_1.id  
}

