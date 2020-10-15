output "name" {
  value = rancher2_cluster.the_cluster.name
}

output "id" {
  value = rancher2_cluster.the_cluster.id
}

output "resource_group" {
  value = module.resource_group.name
}

output "kubernetes_version" {
  value = var.kubernetes_version
}