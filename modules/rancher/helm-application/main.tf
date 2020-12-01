data "rancher2_namespace" "namespace" {
  provider    = rancher2
  count = var.create_namespace ? 0 : 1
  name = var.namespace
  project_id = var.system_id
}

resource "rancher2_namespace" "main" {
  provider    = rancher2
  count = var.create_namespace ? 1 : 0
  name        = var.namespace
  project_id  = var.project_id
}

resource "rancher2_app" "helm_app" {
  provider          = rancher2
  catalog_name      = var.catalog_name
  name              = var.template_name
  project_id        = var.create_namespace ? var.project_id : var.system_id # This is a hack and we should refactor so that var.project always contains the correct project id regardless if it is system
  target_namespace  = var.create_namespace ? rancher2_namespace.main[0].name : data.rancher2_namespace.namespace[0].name
  template_name     = var.template_name
}