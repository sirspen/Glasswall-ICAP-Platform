//resource "rancher2_project" "icap-service" {
//  provider    = rancher2.adm
//  name       = "icapservice"
//  cluster_id = var.cluster_ids[0]
//  wait_for_cluster = true
//}

//resource "rancher2_multi_cluster_app" "icapadaptation" {
//  provider    = rancher2.admin
//  catalog_name = var.catalogue_name
//  name         = "icapadaptation"
//  targets {
//    project_id = var.cluster_ids[0]
//  }
//  template_name = "icap-adaptation"
//  roles         = ["cluster-owner"]
//}
//
//resource "rancher2_multi_cluster_app" "rabbitmq" {
//  provider    = rancher2.admin
//  catalog_name = var.catalogue_name
//  name         = "rabbitmq"
//  dynamic "targets" {
//    for_each = var.cluster_ids
//    content {
//      project_id = targets.value
//    }
//  }
//  template_name = "icap-rabbitmq"
//  roles         = ["cluster-owner"]
//}
//
//resource "rancher2_multi_cluster_app" "systemclusterrole" {
//  provider    = rancher2.admin
//  catalog_name = var.catalogue_name
//  name         = "systemclusterrole"
//  targets {
//    project_id = var.cluster_ids[0]
//  }
//  template_name = "systemclusterrole"
//  roles         = ["cluster-owner"]
//}