
output "cluster_name" {
  value = module.icap_service.cluster_name
}

output "resource_group" {
  value = module.resource_group.name
}

output "network" {
  value = module.network.name
}

output "network_id" {
  value = module.network.id
}

output "subnet" {
  value = module.subnet.name
}

output "icap_service_dns_name" {
  value = azurerm_dns_a_record.icap_service_dns.fqdn
}