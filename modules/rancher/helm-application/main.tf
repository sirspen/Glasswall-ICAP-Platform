resource "rancher2_namespace" "application_namespace" {
  provider    = rancher2.adm
  name = var.namespace
  for_each = var.project_ids
  project_id = each.value
}

resource "rancher2_app" "helm_app" {
  provider    = rancher2.adm
  catalog_name = var.catalogue_name
  name         = var.template_name
  for_each = var.project_ids
  project_id = each.value
  target_namespace = rancher2_namespace.application_namespace[each.key].id
  template_name = var.template_name
  timeouts {
    create = "1m" #TODO remove timeout
  }
}