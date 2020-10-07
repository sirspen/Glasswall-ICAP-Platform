
locals {
  project = "${var.project}-${var.suffix}"
}

module "azure_virtual_machine" {
  source                  = "../../azure/vm"
  organisation            = var.organisation
  environment             = var.environment
  project                 = local.project
  os_sku                  = "7-LVM"
  os_offer                = "RHEL"
  os_publisher            = "RedHat"
  azure_region            = "ukwest"
  custom_data_file_path   = var.custom_data_file_path
  network_cidr_range      = ["10.10.0.0/16"]
  network_subnet_prefixes = ["10.10.2.0/24"]
  network_subnet_names    = ["subnet-1"]
}
