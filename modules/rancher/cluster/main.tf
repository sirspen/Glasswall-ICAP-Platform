
module "resource_group" {
  source                  = "../../azure/resource_group"
  name                    = var.cluster_name
  region                  = var.azure_region
}

module "network" {
  source                  = "../../azure/network"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  region                  = var.azure_region
  service_name            = var.cluster_name
  address_space           = var.address_space
}

module "subnet" {
  source                  = "../../azure/subnet"
  service_name            = var.cluster_name
  resource_group          = module.resource_group.name
  virtual_network_name    = module.network.name
  address_prefixes        = var.subnet_cidr
}

resource "rancher2_cluster" "the_cluster" {
  provider    = rancher2.admin
  name        = var.cluster_name
  description = "Cluster to run the ICAP Service"

  rke_config {
   # cloud_provider  = "azure_cloud_provider"
    cloud_provider {
      azure_cloud_provider {
        tenant_id                      = var.tenant_id
        subscription_id                = var.subscription_id
        aad_client_id                  = var.client_id
        aad_client_secret              = var.client_secret
        subnet_name                    = module.subnet.name
        vnet_name                      = module.network.name
        vnet_resource_group            = module.resource_group.name
      }
        #  primary_availability_set_name =
        #  primary_scale_set_name        =
        #  route_table_name              =
    }  
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
