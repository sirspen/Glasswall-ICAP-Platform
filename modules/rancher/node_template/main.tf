
provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

data "rancher2_cloud_credential" "credentials" {
    name = var.credential_name
}

resource "rancher2_node_template" "template_az" {
  name = var.service_name
  cloud_credential_id = rancher2_cloud_credential.credentials.id
  engine_install_url = var.docker_url
  azure_config {
    disk_size = var.node_disk_size
    image = var.node_image
    location = var.region
    managed_disks = true
    no_public_ip = false
    open_port = var.node_ports
    resource_group = module.resource_group.name
    storage_type = var.node_storage_type
    size = var.node_type
    use_private_ip = false
  }
}