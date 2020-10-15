
provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

module "resource_group" {
  source                  = "../../azure/resource_group"
  service_name            = var.service_name
  region                  = var.azure_region
}

resource "rancher2_cluster" "the_cluster" {
  provider    = "rancher2.admin"
  name        = var.cluster_name
  description = "Cluster to run the ICAP Service"

  rke_config {
    network {
      plugin  = var.cluster_network_plugin
    }
    services {
      etcd {
        creation = "6h"
        retention = "24h"
      }
      kube_api {
        audit_log {
          enabled = true
          configuration {
            max_age = 5
            max_backup = 5
            max_size = 100
            path = "-"
            format = "json"
            policy = "apiVersion: audit.k8s.io/v1\nkind: Policy\nmetadata:\n  creationTimestamp: null\nomitStages:\n- RequestReceived\nrules:\n- level: RequestResponse\n  resources:\n  - resources:\n    - pods\n"
          }
        }
      }
    }
    upgrade_strategy {
      drain = true
      max_unavailable_worker = "20%"
    }
    kubernetes_version = var.kubernetes_version
  }
}
