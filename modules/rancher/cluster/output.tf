output "cluster_name" {
  value = rancher2_cluster.the_cluster.name
}

output "cluster_id" {
  value = rancher2_cluster.the_cluster.id
}

output "kubernetes_version" {
  value = var.kubernetes_version
}