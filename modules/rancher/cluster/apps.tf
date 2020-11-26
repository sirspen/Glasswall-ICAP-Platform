data "rancher2_project" "system" {
  provider         = rancher2
  cluster_id       = rancher2_cluster.main.id
  name             = "System"
}

resource "rancher2_project" "main" {
  provider         = rancher2
  name             = var.rancher_projects
  cluster_id       = rancher2_cluster.main.id
  wait_for_cluster = true
}

module "clusters_apps"{
  source = "../helm-application"
  for_each         = var.cluster_apps
  namespace        = each.value.namespace
  catalogue_name   = each.value.catalog_name
  template_name    = each.value.template_name
  project_id       = rancher2_project.main.id
}