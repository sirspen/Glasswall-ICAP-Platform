
output "resource_groups" {
  value = [
    for cluster in module.icap_clusters:
    cluster.resource_group_name
  ]
}

output "system_ids" {
  value = flatten([
    for cluster in module.icap_clusters:
      cluster.system_ids
  ])
}

output "project_ids" {
  value = flatten([
    for cluster in module.icap_clusters:
    cluster.project_ids
  ])
}

output "cluster_worker_lb_dns_names" {
  value = [
    for cluster in module.icap_clusters:
    cluster.cluster_worker_lb_dns_name
  ]
}

output "cluster_worker_lb_ip_addr" {
  value = [
    for cluster in module.icap_clusters:
    cluster.worker_lb_ip_address
  ]
}

/*
output "r1_resource_group" {
  value = module.icap_clusters.["northeurope"]
}

output "r1_network_name" {
  value = module.icap_clusters.network_name
}

output "r1_network_id" {
  value = module.icap_clusters.network_id
}

output "r1_subnet_name" {
  value = module.icap_clusters.subnet_name
}
/*
output "r1_cluster_worker_lb_dns_name" {
  value = module.icap_clusters.cluster_worker_lb_dns_name
}

output "r1_cluster_worker_lb_ip_addr" {
  value = module.icap_clusters.worker_lb_ip_address
}*/
