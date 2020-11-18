variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "azure_region" {
  description = "The Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "The Azure Region"
  type        = string
}

variable "security_group_rule" {
  description = "Should we add rules now or later"
  type        = number
  default     = 0
}

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
    source_application_security_group_ids       = list(string)
    destination_application_security_group_ids  = list(string)
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
      source_application_security_group_ids       = []
      destination_application_security_group_ids  = []
    }
  }
}

