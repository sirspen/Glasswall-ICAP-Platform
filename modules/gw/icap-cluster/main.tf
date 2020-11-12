locals {
  cluster_name            = "${var.service_name}-${var.suffix}"
}

module "icap_cluster" {
  source                      = "../../rancher/cluster"
  organisation                = var.organisation
  environment                 = var.environment
  rancher_admin_url           = var.rancher_admin_url
  rancher_admin_token         = var.rancher_admin_token
  cluster_name                = local.cluster_name
  service_name                = var.service_name
  azure_region                = var.azure_region
  client_id                   = var.client_id
  tenant_id                   = var.tenant_id
  client_secret               = var.client_secret
  subscription_id             = var.subscription_id
  resource_group              = var.cluster_resource_group
  virtual_network_name        = var.cluster_virtual_network_name
  subnet_name                 = var.cluster_subnet_name
# scaleset_name               = module.scaleset.name
  scaleset_name               = "${local.cluster_name}-master"
}
/*
data "template_file" "master_scaleset_nodes" {
  template                        = file("../../../scripts/user-data.template")
  depends_on                      = [module.icap_cluster]
  vars {
    cluster_name                  = "${local.cluster_name}"
    rancher_agent_version         = "v2.5.1"
    rancher_server_url            = var.rancher_admin_url
    rancher_agent_token           = module.icap_cluster.token
    node_pool_role                = "master"
    public_key_openssh            = var.public_key_openssh
  }
}*/


module "master_scaleset" {
    source                      = "../../azure/scale-set"
    depends_on                  = [module.icap_cluster]
    organisation                = var.organisation
    environment                 = var.environment
    service_name                = "${local.cluster_name}-master"
    tag_cluster_name            = local.cluster_name
    tag_cluster_asg_state       = "disabled"
    service_role                = "master"
    resource_group              = var.cluster_resource_group
    subnet_id                   = var.cluster_subnet_id
    region                      = var.azure_region
    size                        = "Standard_DS2_v2"
    os_publisher                = var.os_publisher
    os_offer                    = var.os_offer
    os_sku                      = var.os_sku
    os_version                  = var.os_version
    size                        = var.master_scaleset_size
    sku_capacity                = var.master_scaleset_sku_capacity
    admin_username              = var.master_scaleset_admin_user
    #custom_data_file_path      = data.template_file.master_scaleset_nodes.rendered
    custom_data                 = templatefile("${path.module}/tmpl/user-data.template",{
      cluster_name              = local.cluster_name
      rancher_agent_version     = "v2.5.1"
      rancher_server_url        = var.rancher_internal_api_url
      rancher_agent_token       = module.icap_cluster.token
      crt_cluster_token         = module.icap_cluster.crt_cluster_token
      node_pool_role            = "master"
      public_key_openssh        = var.public_key_openssh
      rancher_ca_checksum       = ""
    })
    public_key_openssh          = var.public_key_openssh
    loadbalancer                = false
  }
/*
data "template_file" "worker_scaleset_nodes" {
  template                        = file("../../../scripts/user-data.template")
  depends_on                      = [module.icap_cluster]
  vars {
    cluster_name                  = "${local.cluster_name}"
    rancher_agent_version         = "v2.5.1"
    rancher_server_url            = var.rancher_admin_url
    rancher_agent_token           = module.icap_cluster.token
    node_pool_role                = "worker"
    public_key_openssh            = var.public_key_openssh
  }
}*/

module "worker_scaleset" {
    source                      = "../../azure/scale-set"
    depends_on                  = [module.icap_cluster]
    organisation                = var.organisation
    environment                 = var.environment
    service_name                = "${local.cluster_name}-worker"
    tag_cluster_name            = local.cluster_name
    tag_cluster_asg_state       = "enabled"
    service_role                = "worker"
    resource_group              = var.cluster_resource_group
    subnet_id                   = var.cluster_subnet_id
    region                      = var.azure_region
    os_publisher                = var.os_publisher
    os_offer                    = var.os_offer
    os_sku                      = var.os_sku
    os_version                  = var.os_version
    size                        = var.worker_scaleset_size
    sku_capacity                = var.worker_scaleset_sku_capacity
    admin_username              = var.worker_scaleset_admin_user
    custom_data                 = templatefile("${path.module}/tmpl/user-data.template",{
      cluster_name                  = local.cluster_name
      rancher_agent_version         = "v2.5.1"
      rancher_server_url            = var.rancher_admin_url
      rancher_agent_token           = module.icap_cluster.token
      crt_cluster_token             = module.icap_cluster.crt_cluster_token
      node_pool_role                = "worker"
      public_key_openssh            = var.public_key_openssh
      rancher_ca_checksum           = ""
    })
    #custom_data_file_path      = data.template_file.worker_scaleset_nodes.rendered
    public_key_openssh          = var.public_key_openssh
    loadbalancer                = true
    lb_backend_address_pool_id  = [var.worker_lb_bap_id]
    lb_probe_id                 = var.worker_lb_probe_id
  }
