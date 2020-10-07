

module "glasswall_icap" {
  source                  = "./modules/glasswall/icap"
  organisation            = "gw"
  project                 = "icap"
  environment             = "dev"
  suffix                  = "1"
  custom_data_file_path   = filebase64("scripts/start-rancher-server.sh")
}
