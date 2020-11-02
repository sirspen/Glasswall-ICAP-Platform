module "git_server_public_ip" {
  source                  = "../azure/public_ip"
  resource_group          = module.resource_group.name
  region                  = var.azure_region
  service_name            = local.service_name
  service_type            = "git_server"
  organisation            = var.organisation
  environment             = var.environment
}

module "git_server" {
  source                  = "../azure/vm"
  resource_group          = module.resource_group.name
  organisation            = var.organisation
  environment             = var.environment
  service_name            = "git-${local.service_name}"
  service_type            = "git_server"
  os_sku                  = "7-LVM"
  os_offer                = "RHEL"
  os_publisher            = "RedHat"
  region                  = var.azure_region
  custom_data_file_path   = var.custom_git_server_data_file_path
  subnet_id               = module.subnet.id
  public_ip_id            = module.git_server_public_ip.id
  public_key_openssh      = tls_private_key.ssh.public_key_openssh
}

resource "azurerm_dns_a_record" "git_server" {
  name                = local.service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.git_server.linux_vm_public_ips]
}