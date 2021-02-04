data "rancher2_namespace" "namespace" {
  provider    = rancher2
  count       = var.create_namespace ? 0 : 1
  name        = var.namespace
  project_id  = var.system_id
}

resource "rancher2_namespace" "main" {
  provider    = rancher2
  count       = var.create_namespace ? 1 : 0
  name        = var.namespace
  project_id  = var.system_app ? var.system_id : var.project_id
}

resource "rancher2_app" "helm_app" {
  provider          = rancher2
  catalog_name      = var.catalog_name
  name              = var.template_name
  # This is a hack and we should refactor so that var.project always contains the correct project id regardless if it is system
  project_id        = var.system_app ? var.system_id : var.project_id
  target_namespace  = var.create_namespace ? rancher2_namespace.main[0].name : data.rancher2_namespace.namespace[0].name
  template_name     = var.template_name
  answers = {
    "ingress.host"                                                                = var.admin_cluster_lb_name
    "adaptationservice.repoUrl"                                                   = var.helm_chart_repo_url
    "adminservice.repoUrl"                                                        = var.helm_chart_repo_url
    "containerregistry.dockerconfigjson"                                          = var.docker_config_json
    "policymanagementapi.PolicyUpdateServiceEndpointCsv"                          = var.policy_update_endpoint_csv
    "policymanagementapi.NcfsPolicyUpdateServiceEndpointCsv"                      = var.ncfs_endpoint_csv
    "transactionqueryaggregator.configuration.TransactionQueryServiceEndpointCsv" = var.transaction_event_endpoint_csv
  }

  lifecycle {
    ignore_changes = [
      project_id
    ]
  }
}
