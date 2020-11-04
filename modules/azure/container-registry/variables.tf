variable "resource_group_name" {
  type        = string
  description = "The resource group name"
  default     = "gw-icap-container-registry-rg"
}

variable "location" {
  description = "The Azure Location"
  type        = string
  default     = "uksouth"
}
