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

output "master_lb_id" {
  value = module.master_lb.id   
}

output "worker_lbap_id" {
  value = azurerm_lb_backend_address_pool.worker_lbap.id
}

output "master_lbap_id" {
  value = azurerm_lb_backend_address_pool.master_lbap.id
}

output "master_ingress_probe_id" {
  value = azurerm_lb_probe.master_ingress_probe.id
}

output "master_ingress_rule_1_id" {
  value = azurerm_lb_rule.master_ingress_rule_1.id  
}

output "master_lb_dns_name" {
  value = azurerm_dns_a_record.main_master.fqdn
}

output "master_lb_ip_address" {
  value = module.master_lb.private_ip_address
}

output "worker_ingress_probe_id" {
  value = azurerm_lb_probe.worker_ingress_probe.id
}

output "worker_ingress_rule_1_id" {
  value = azurerm_lb_rule.worker_ingress_rule_1.id  
}

output "worker_lb_dns_name" {
  value = azurerm_dns_a_record.main_worker.fqdn
}

output "worker_lb_ip_address" {
  value = module.worker_lb.public_ip_address
}

