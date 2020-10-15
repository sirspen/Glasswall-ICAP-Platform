
module "rancher_server" {
  source                  = "./modules/rancher-bootstrap"
  organisation            = "gw"
  project                 = "icap"
  environment             = "dev"
  suffix                  = "p1"
  azure_region            = "ukwest"
  custom_data_file_path   = filebase64("scripts/start-rancher-server.sh")
}

module "icap_cluster" {
  source                  = "./modules/glasswall/icap"  
}
