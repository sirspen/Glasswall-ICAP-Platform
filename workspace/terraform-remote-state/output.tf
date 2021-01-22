output "storage_resource_group" {
  value = module.storage.storage_resource_group
}

output "storage_access_key" {
  value = module.storage.storage_access_key
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_container_name" {
  value = module.storage.storage_container_name
}

output "backend_rancher_bootstrap_03" {
  value = local.backend_rancher_server
}

output "backend_rancher_clusters_04" {
  value = local.backend_rancher_cluster
}

output "backend_container_registry_02" {
  value = local.backend_container_registry
}

output "keyvault_id" {
  value = module.key_vault_storage.keyvault_id
}

output "keyvault_uri" {
  value = module.key_vault_storage.keyvault_uri
}

output "keyvault_resource_group" {
  value = module.key_vault_storage.keyvault_resource_group
}

output "keyvault_name" {
  value = module.key_vault_storage.keyvault_name
}

