output "c1_cluster_name" {
  value = module.icap_cluster_c1.cluster_name
}

output "c1_resource_group" {
  value = module.icap_cluster_c1.resource_group_name
}

output "c1_network_name" {
  value = module.icap_cluster_c1.network_name
}

output "c1_network_id" {
  value = module.icap_cluster_c1.network_id
}

output "c1_subnet_name" {
  value = module.icap_cluster_c1.subnet_name
}

output "c2_cluster_name" {
  value = module.icap_cluster_c2.cluster_name
}

output "c2_resource_group" {
  value = module.icap_cluster_c2.resource_group_name
}

output "c2_network_name" {
  value = module.icap_cluster_c2.network_name
}

output "c2_network_id" {
  value = module.icap_cluster_c2.network_id
}

output "c2_subnet_name" {
  value = module.icap_cluster_c2.subnet_name
}

output "primary_access_key" {
  value = module.storage_account.primary_access_key
}

output "primary_access_region" {
  value = module.storage_account.primary_access_region
}

output "secondary_access_key" {
  value = module.storage_account.secondary_access_key
}

output "secondary_access_region" {
  value = module.storage_account.secondary_access_region
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name
}