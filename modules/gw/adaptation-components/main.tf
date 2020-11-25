module "adaptation" {
  providers = {
    rancher2.adm = rancher2.adm
  }
  source = "../../rancher/helm-application"
  catalogue_name = var.catalogue_name
  namespace = "icap-adaptation"
  project_ids = var.project_ids
  rancher_admin_token = var.rancher_admin_token
  rancher_admin_url = var.rancher_admin_url
  template_name = "icap-adaptation"
}

module "rabbitmq" {
  providers = {
    rancher2.adm = rancher2.adm
  }
  source = "../../rancher/helm-application"
  catalogue_name = var.catalogue_name
  namespace = "icap-rabbitmq"
  project_ids = var.project_ids
  rancher_admin_token = var.rancher_admin_token
  rancher_admin_url = var.rancher_admin_url
  template_name = "icap-rabbitmq"
}

module "system" {
  providers = {
    rancher2.adm = rancher2.adm
  }
  source = "../../rancher/helm-application"
  catalogue_name = var.catalogue_name
  namespace = "kube-system"
  project_ids = var.system_project_ids
  rancher_admin_token = var.rancher_admin_token
  rancher_admin_url = var.rancher_admin_url
  template_name = "systemclusterrole"
}