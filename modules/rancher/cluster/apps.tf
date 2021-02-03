data "rancher2_project" "system" {
  provider         = rancher2
  depends_on       = [rancher2_cluster.main]
  cluster_id       = rancher2_cluster.main.id
  name             = "System"
}

resource "rancher2_project" "main" {
  provider         = rancher2
  depends_on       = [rancher2_cluster.main]
  name             = var.rancher_projects
  cluster_id       = rancher2_cluster.main.id
  wait_for_cluster = true
  timeouts {
    create = "30m"
  }
}

module "cluster_apps_stage1" {
  source               = "../helm-application"
  depends_on           = [rancher2_project.main]
  for_each             = var.cluster_stage1_apps
  namespace            = each.value.namespace
  catalog_name         = each.value.catalog_name
  template_name        = each.value.template_name
  create_namespace     = each.value.create_namespace
  project_id           = rancher2_project.main.id
  system_id            = data.rancher2_project.system.id
  system_app           = each.value.system_app
  helm_chart_repo_url  = var.helm_chart_repo_url
  docker_config_json   = var.docker_config_json
  admin_cluster_lb_name             = var.admin_cluster_lb_name
  policy_update_endpoint_csv        = var.policy_update_endpoint_csv
  transaction_event_endpoint_csv    = var.transaction_event_endpoint_csv
  ncfs_endpoint_csv                 = var.ncfs_endpoint_csv
}