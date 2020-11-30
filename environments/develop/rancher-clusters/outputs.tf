
output "icap_resource_groups" {
  value = module.rancher_clusters.icap_resource_groups
}

output "icap_system_ids" {
  value = module.rancher_clusters.icap_system_ids
}
/*
output "admin_system_ids" {
  value = module.rancher_clusters.icap_system_ids
}*/

output "icap_project_ids" {
  value = module.rancher_clusters.icap_project_ids
}
/*
output "admin_project_ids" {
  value = module.rancher_clusters.admin_project_ids
}*/

output "icap_loadbalancers" {
  value =  module.rancher_clusters.icap_cluster_worker_lb_dns_names
}
/*
output "admin_loadbalancers" {
  value =  module.rancher_clusters.admin_clusters_worker_lb_dns_names
}*/
/*
output "cluster_worker_lb_ip_addr" {
  value = [
    for cluster in module.icap_clusters:
    cluster.worker_lb_ip_address
  ]
}


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
