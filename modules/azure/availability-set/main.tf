
locals{
  domain_count = (var.region == "ukwest")? 2: 3 
}

resource "azurerm_availability_set" "availability_set" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  platform_update_domain_count  = local.domain_count
  platform_fault_domain_count   = local.domain_count
}