variable "service_name" {
  description = "Service Name"
  type        = string
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}

variable "virtual_network_name" {
  description = "Azure Virtual Network Name"
  type        = string
}

variable "address_prefixes" {
  description = "Azure Subnet Prefixes"
  type        = list(string)
}

