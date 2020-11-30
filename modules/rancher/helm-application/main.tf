data "rancher2_namespace" "namespace" {
  count = var.create_namespace ? 0 : 1
  name = var.namespace
  project_id = var.project_id
}

resource "rancher2_namespace" "main" {
  count = var.create_namespace ? 1 : 0
  provider    = rancher2
  name        = var.namespace
  project_id  = var.project_id
}

resource "rancher2_app" "helm_app" {
  provider          = rancher2
  catalog_name      = var.catalog_name
  name              = var.template_name
  project_id        = var.project_id
  target_namespace  = var.create_namespace ? rancher2_namespace.main.name : data.rancher2_namespace.namespace.name
  template_name     = var.template_name
}