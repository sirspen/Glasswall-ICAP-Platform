variable "resource_group_name" {
  type        = string
  description = "The resource group name"
  default     = "gw-icap-load-balancer"
}

variable "location" {
  description = "The Azure Location"
  type        = string
  default     = "UK South"
}