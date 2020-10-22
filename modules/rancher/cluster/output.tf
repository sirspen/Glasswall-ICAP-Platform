output "cluster_name" {
  value = rancher2_cluster.the_cluster.name
}

output "cluster_id" {
  value = rancher2_cluster.the_cluster.id
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

output "kubernetes_version" {
  value = var.kubernetes_version
}