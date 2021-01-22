# get the output from 01_terraform-remote-state
terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    #backend_key_container_registry_02
    key                  = ""
  }
}

module "containers" {
  source                 = "../../../workspace/container-registry"
  organisation           = ""
  environment            = "" #can be anything short to identify this stacks change tier
  project                = "containerregistry"
  suffix                 = "z1" #z1 this helps to simplify how many of these standalone stacks you can have, foreach increment this one 
  azure_region           = "" #ukwest etc
  storage_tier           = "Standard"
  replication_type       = "LRS"
  tenant_id              = ""
  subscription_id        = ""
}