/*
"${var.organisation}-${var.project}-${var.environment}-${var.suffix}"
*/
module "remote_state" {
  source                 = "../../../workspace/terraform-remote-state"
  organisation           = "gw"
  environment            = "dev"
  project                = "remotestatestore"
  suffix                 = "z1"
  azure_region           = "ukwest"
  storage_tier           = "Standard"
  replication_type       = "LRS"
}