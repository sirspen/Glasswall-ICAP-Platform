output "a_message" {
  value = "These outputs are required in all subsequent terraform runs"
}

output "storage_access_key" {
  value = module.remote_state.storage_access_key
}

output "storage_account_name" {
  value = module.remote_state.storage_account_name
}

output "container_name" {
  value = module.remote_state.storage_container_name
}

output "resource_group_name" {
  value = module.remote_state.storage_resource_group
}

output "backend_key_rancher_bootstrap_03" {
  value = module.remote_state.backend_rancher_bootstrap_03
}

output "backend_key_rancher_clusters_04" {
  value = module.remote_state.backend_rancher_clusters_04
}

output "backend_key_container_registry_02" {
  value = module.remote_state.backend_container_registry_02
}

output "keyvault_resource_group" {
  value = module.key_vault_storage.keyvault_resource_group
}

output "keyvault_id" {
  value = module.remote_state.keyvault_id
}

output "keyvault_uri" {
  value = module.remote_state.keyvault_uri
}