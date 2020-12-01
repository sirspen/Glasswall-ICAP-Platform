
output "cloud_credentials_id" {
  value = module.azure_cloud_credentials.id
}

output "resource_group_name" {
  value = var.cluster_resource_group_name
}

output "network_name" {
  value = var.cluster_network_name
}

output "subnet_name" {
  value = var.cluster_subnet_name
}

output "system_ids" {
  value = module.cluster.system_id
}

output "project_ids" {
  value = module.cluster.project_id
}

output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_id" {
  value = module.cluster.cluster_id
}

output "crt_cluster_token" {
  value = module.cluster.crt_cluster_token
}

output "crt_cluster_id" {
  value = module.cluster.crt_cluster_id
}

output "crt_cluster_node_command" {
  value = module.cluster.crt_cluster_node_command
}

output "kubernetes_version" {
  value = module.cluster.kubernetes_version
}

output "cluster_access_key" {
  value = module.cluster.access_key
}

output "cluster_secret_key" {
  value = module.cluster.secret_key
}

output "cluster_token_enabled" {
  value = module.cluster.token_enabled
}

output "cluster_worker_lb_dns_name" {
  value = azurerm_dns_a_record.main_worker.fqdn
}

output "worker_lb_ip_address" {
  value = module.worker_lb.public_ip_address
}