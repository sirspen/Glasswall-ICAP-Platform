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

module "catalog" {
  source = "../catalogue"
  for_each = var.cluster_catalogues
  helm_charts_repo_url    = "${each.value.helm_charts_repo_url}/icap-infrastructure.git"
  helm_charts_repo_branch = each.value.helm_charts_repo_branch
  cluster_id = rancher2_cluster.main.id
}

module "clusters_apps"{
  source = "../helm-application"
  for_each    = var.cluster_apps
  namespace   = each.value.namespace
  project_id = rancher2_project.main.id
  catalogue_name = each.value.catalogue_name
  template_name = each.value.template_name
}