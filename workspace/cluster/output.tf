
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