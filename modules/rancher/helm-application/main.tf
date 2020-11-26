resource "rancher2_namespace" "main" {
  provider    = rancher2
  name        = var.namespace
  project_id  = var.project_id
}

resource "rancher2_app" "helm_app" {
  provider          = rancher2
  catalog_name      = var.catalog_name
  name              = var.template_name
  project_id        = var.project_id
  target_namespace  = rancher2_namespace.main.name
  template_name     = var.template_name
  timeouts {
    create = "1m" #TODO remove timeout
  }
}