

output "icap_cluster_lb_dns_names" {
  value = module.rancher_clusters.icap_cluster_worker_lb_dns_names
}

output "icap_cluster_lb_ip_addr" {
  value = module.rancher_clusters.icap_cluster_worker_lb_ip_addr
}

output "admin_cluster_lb_dns_names" {
  value = module.rancher_clusters.admin_cluster_worker_lb_dns_names
}
