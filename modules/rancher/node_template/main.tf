
provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

data "rancher2_cloud_credential" "credentials" {
    name = var.credential_name
}

resource "rancher2_node_template" "node_template" {
  name = var.service_name
  cloud_credential_id     = rancher2_cloud_credential.credentials.id
  engine_install_url      = var.docker_url
    azure_config {
      disk_size             = var.node_disk_size
      image                 = var.node_image
      location              = var.azure_region
      managed_disks         = true
      no_public_ip          = false
      open_port             = var.node_ports
      resource_group        = module.resource_group.name
      storage_type          = var.node_storage_type
      size                  = var.node_type
      use_private_ip        = false
      vnet                  = var.cluster_virtual_machine_net
      subnet                = var.cluster_subnet_name
      subnet_prefix         = var.cluster_subnet_prefix
    }
}