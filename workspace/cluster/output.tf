output "r1_cluster_name" {
  value = module.icap_cluster_r1.cluster_name
}

output "r1_resource_group" {
  value = module.icap_cluster_r1.resource_group_name
}

output "r1_network_name" {
  value = module.icap_cluster_r1.network_name
}

output "r1_network_id" {
  value = module.icap_cluster_r1.network_id
}

output "r1_subnet_name" {
  value = module.icap_cluster_r1.subnet_name
}

output "r2_cluster_name" {
  value = module.icap_cluster_r2.cluster_name
}

output "r2_resource_group" {
  value = module.icap_cluster_r2.resource_group_name
}

output "r2_network_name" {
  value = module.icap_cluster_r2.network_name
}

output "r2_network_id" {
  value = module.icap_cluster_r2.network_id
}

output "r2_subnet_name" {
  value = module.icap_cluster_r2.subnet_name
}

output "r1_icap_service_dns_name" {
  value = module.icap_cluster_r1.cluster_lb_dnsname
}

output "r2_icap_service_dns_name" {
  value = module.icap_cluster_r2.cluster_lb_dnsname
}
