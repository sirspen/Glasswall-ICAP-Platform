resource "rancher2_project" "icap-service" {
  provider         = rancher2.adm
  name             = "icapservice"
  cluster_id       = var.cluster_ids[0]
  wait_for_cluster = true
}

data "rancher2_project" "system" {
  provider         = rancher2.adm
  cluster_id = var.cluster_ids[0]
  name = "System"
}

resource "rancher2_multi_cluster_app" "systemclusterrole" {
  provider    = rancher2.adm
  catalog_name = var.catalogue_name
  name         = "systemclusterrole"
  targets {
    project_id = data.rancher2_project.system.id
  }
  template_name = "systemclusterrole"
  roles         = ["cluster-owner"]
}

resource "rancher2_multi_cluster_app" "rabbitmq" {
  provider    = rancher2.adm
  catalog_name = var.catalogue_name
  name         = "rabbitmq"
  targets {
    project_id = rancher2_project.icap-service.id
  }
  template_name = "icap-rabbitmq"
  roles         = ["project-owner"]
}

resource "rancher2_multi_cluster_app" "icapadaptation" {
  provider     = rancher2.adm
  catalog_name = var.catalogue_name
  name         = "icap-adaptation"
  targets {
    project_id = rancher2_project.icap-service.id
  }
  template_name = "icap-adaptation"
  roles         = ["project-owner"]
}