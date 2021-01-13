
module "remote_state" {
  source                 = "../../../workspace/terraform-remote-state"
  organisation           = ""
  environment            = "" #can be anything short to identify this stacks change tier
  project                = "remotestatestore"
  suffix                 = "z1" #z1 this helps to simplify how many of these standalone stacks you can have, foreach increment this one 
  azure_region           = "" #ukwest etc
  storage_tier           = "Standard"
  replication_type       = "LRS"
  tenant_id              = ""
  subscription_id        = ""
}