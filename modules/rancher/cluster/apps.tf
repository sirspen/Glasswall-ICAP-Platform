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
  source           = "../helm-application"
  depends_on       = [rancher2_project.main]
  for_each         = var.cluster_stage1_apps
  namespace        = each.value.namespace
  catalog_name     = each.value.catalog_name
  template_name    = each.value.template_name
  create_namespace = each.value.create_namespace
  project_id       = rancher2_project.main.id
  system_id        = data.rancher2_project.system.id
  system_app       = each.value.system_app
}

module "cluster_apps_stage2" {
  source           = "../helm-application"
  depends_on       = [module.cluster_apps_stage1]
  for_each         = var.cluster_stage2_apps
  namespace        = each.value.namespace
  catalog_name     = each.value.catalog_name
  template_name    = each.value.template_name
  create_namespace = each.value.create_namespace
  project_id       = rancher2_project.main.id
  system_id        = data.rancher2_project.system.id
  system_app       = each.value.system_app
}