output "name" {
  value = rancher2_cluster.the_cluster.name
}

output "id" {
  value = rancher2_cluster.the_cluster.id
}

output "resource_group" {
  value = module.resource_group.name
}

output "cluster_network" {
  value = module.network.name
}

output "cluster_network_id" {
  value = module.network.id
}

output "cluster_subnet" {
  value = module.subnet.name
}

output "kubernetes_version" {
  value = var.kubernetes_version
}