
resource "rancher2_cluster" "the_cluster" {
  provider    = rancher2.admin
  name        = var.cluster_name
  description = "Cluster to run the ICAP Service"

  rke_config {
    ignore_docker_version = true
    cloud_provider {
      name = "azure"
      azure_cloud_provider {
        tenant_id                      = var.tenant_id
        subscription_id                = var.subscription_id
        aad_client_id                  = var.client_id
        aad_client_secret              = var.client_secret
        subnet_name                    = var.subnet_name
        vnet_name                      = var.virtual_network_name
        resource_group                 = var.resource_group
      }
        #  primary_availability_set_name =
        #  primary_scale_set_name        =
        #  route_table_name              =
    }  
    network {
      plugin  = var.cluster_network_plugin
    }
    /*services {
      etcd {
        creation = "6h"
        retention = "24h"
      }
      kube_api {
        audit_log {
          enabled = true
        }
      }
    }
    upgrade_strategy {
      drain = true
      max_unavailable_worker = "20%"
    }*/
    kubernetes_version = var.kubernetes_version
  }
}
