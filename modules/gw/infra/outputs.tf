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

output "int_worker_lb_id" {
  value = module.int_worker_lb.id   
}

output "worker_lbap_id" {
  value = azurerm_lb_backend_address_pool.worker_lbap.id
}

output "int_worker_lbap_id" {
  value = azurerm_lb_backend_address_pool.int_worker_lbap.id
}

output "int_worker_ingress_probe_id" {
  value = azurerm_lb_probe.int_worker_ingress_probe.id
}

output "int_worker_ingress_rules_ids" {
   value = flatten([
    for rule in azurerm_lb_rule.int_worker_ingress_rules:
      rule.id
  ]) 
}

output "int_worker_lb_dns_name" {
  value = azurerm_dns_a_record.main_int_worker.fqdn
}

output "int_worker_lb_ip_address" {
  value = module.int_worker_lb.private_ip_address
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

output "security_group_id" {
  value = module.security_group.id
}

output "security_group_name" {
  value = module.security_group.name
}
