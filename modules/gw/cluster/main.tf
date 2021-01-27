locals {
  short_region = substr(var.azure_region, 0, 3)
  cluster_name = "${var.service_name}-${local.short_region}-${var.suffix}"
}

module "azure_cloud_credentials" {
  source              = "../../rancher/cloud_credentials"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  credential_name     = local.cluster_name
  client_id           = var.client_id
  client_secret       = var.client_secret
  subscription_id     = var.subscription_id
}

# this module creates the resource group, network, subnet, peering connection.
module "infra" {
  source                    = "../infra"
  organisation              = var.organisation
  environment               = var.environment
  rancher_admin_url         = var.rancher_admin_url
  rancher_internal_api_url  = var.rancher_internal_api_url
  rancher_admin_token       = var.rancher_admin_token
  suffix                    = var.suffix
  service_name              = "${var.service_name}-${local.short_region}"
  azure_region              = var.azure_region
  fault_domain_count        = var.fault_domain_count
  client_id                 = var.client_id
  tenant_id                 = var.tenant_id
  client_secret             = var.client_secret
  subscription_id           = var.subscription_id
  dns_zone                  = var.dns_zone
  cluster_address_space     = var.cluster_address_space
  cluster_subnet_cidr       = var.cluster_subnet_cidr
  cluster_internal_services = var.cluster_internal_services
  public_key_openssh        = var.public_key_openssh
  rancher_resource_group    = var.rancher_resource_group
  rancher_network_id        = var.rancher_network_id
  rancher_network           = var.rancher_network
  backend_port              = var.cluster_backend_port
  public_port               = var.cluster_public_port
  security_group_rules      = var.security_group_rules
}

module "default_master_template" {
  source                      = "../../rancher/node_template"
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  rancher_server_name         = var.rancher_server_name
  rancher_internal_ip         = var.rancher_internal_ip
  service_name                = "${var.service_name}-master-default"
  node_type                   = var.master_scaleset_size
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = module.infra.resource_group_name
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = module.infra.network_name
  cluster_subnet_name         = module.infra.subnet_name
  public_key_openssh          = var.public_key_openssh
}

module "default_worker_template" {
  source                      = "../../rancher/node_template"
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  rancher_server_name         = var.rancher_server_name
  rancher_internal_ip         = var.rancher_internal_ip
  service_name                = "${var.service_name}-stateful-default"
  node_type                   = var.worker_scaleset_size
  azure_region                = var.azure_region
  cluster_subnet_prefix       = var.cluster_subnet_prefix
  resource_group              = module.infra.resource_group_name
  cloud_credentials_id        = module.azure_cloud_credentials.id
  cluster_virtual_machine_net = module.infra.network_name
  cluster_subnet_name         = module.infra.subnet_name
  public_key_openssh          = var.public_key_openssh
}

module "cluster" {
  source                            = "../../rancher/cluster"
  count                             = var.cluster_quantity
  organisation                      = var.organisation
  environment                       = var.environment
  rancher_admin_url                 = var.rancher_admin_url
  rancher_internal_api_url          = var.rancher_internal_api_url
  rancher_admin_token               = var.rancher_admin_token
  rancher_projects                  = var.rancher_projects
  rancher_agent_version             = var.rancher_agent_version
  rancher_internal_ip               = var.rancher_internal_ip
  rancher_server_name               = var.rancher_server_name
  cluster_name                      = "${local.cluster_name}${count.index+1}"
  cluster_stage1_apps               = var.cluster_stage1_apps
  client_id                         = var.client_id
  tenant_id                         = var.tenant_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  azure_region                      = var.azure_region

  resource_group_name               = module.infra.resource_group_name
  virtual_network_name              = module.infra.network_name
  subnet_name                       = module.infra.subnet_name
  subnet_id                         = module.infra.subnet_id
  security_group_id                 = module.infra.security_group_id

  master_scaleset_size              = var.master_scaleset_size
  master_scaleset_sku_capacity      = var.master_scaleset_sku_capacity
  master_scaleset_admin_user        = var.master_scaleset_admin_user
  
  worker_scaleset_size              = var.worker_scaleset_size
  worker_scaleset_sku_capacity      = var.worker_scaleset_sku_capacity
  worker_scaleset_admin_user        = var.worker_scaleset_admin_user
  worker_lb_backend_address_pool_id = [ module.infra.worker_lbap_id, module.infra.int_worker_lbap_id ]
  worker_lb_probe_id                = module.infra.worker_ingress_probe_id

  os_publisher                      = var.os_publisher
  os_offer                          = var.os_offer
  os_sku                            = var.os_sku
  os_version                        = var.os_version
  public_key_openssh                = var.public_key_openssh
  helm_chart_repo_url               = var.helm_chart_repo_url
  docker_config_json                = var.docker_config_json

  default_worker_template_id        = module.default_worker_template.id
  default_master_template_id        = module.default_master_template.id
  add_master_scaleset               = true
  add_worker_scaleset               = true
  add_worker_nodepool               = true
  cluster_worker_labels             = { nodeType = "stateful" }
  cluster_worker_taints             = [{
                                      key = "dedicated"
                                      value = "stateful"
                                      effect = "NoSchedule"
                                    }]
  cluster_endpoint_csv              = var.cluster_endpoint_csv
}

