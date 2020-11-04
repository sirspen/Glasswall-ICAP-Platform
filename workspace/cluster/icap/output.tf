
output "cluster_name" {
  value = module.icap_cluster.cluster_name
}

output "cluster_id" {
  value = module.icap_cluster.cluster_id
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

