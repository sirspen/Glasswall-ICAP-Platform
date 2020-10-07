# Common variables

module "azure_virtual_machine" {
  source                           = "../../azure/vm"
  organisation                     = "gw"
  environment                      = "dev"
  project                          = "icap"
  os_sku                           = "7-LVM"
  os_offer                         = "RHEL"
  os_publisher                     = "RedHat"
  azure_region                     = "ukwest"
  network_cidr_range               = ["10.10.0.0/16"]
  network_subnet_prefixes          = ["10.10.2.0/24"]
  network_subnet_names             = ["subnet-1"]
}
