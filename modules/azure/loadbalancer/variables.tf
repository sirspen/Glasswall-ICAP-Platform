variable "resource_group_name" {
  type        = string
  description = "The resource group name"
  default     = "gw-icap-load-balancer"
}

variable "location" {
  type        = string
  description = "The Azure Location"
  default     = "UK South"
}

variable "network_interface_id" {
  type = string
  description = "The network interface id to associate with the lb backend pool"
}