

variable "security_group_rules" {
  description = "The rules to add as an object"
  type        =  map(object({
    name                                        = string
    priority                                    = string
    direction                                   = string
    access                                      = string
    protocol                                    = string
    source_port_range                           = string
    destination_port_range                      = string
    source_address_prefix                       = string
    destination_address_prefix                  = string
  }))
  default = {
    ssh = {
      name                                        = "RestrictedToSSH"
      priority                                    = 100
      direction                                   = "Inbound"
      access                                      = "Disallow"
      protocol                                    = "Tcp"
      source_port_range                           = "22"
      destination_port_range                      = "22"
      source_address_prefix                       = "*"
      destination_address_prefix                  = "*"
    }
  }
}


variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "network_security_group_name" {
  description = "The network security group name"
  type        = string
}