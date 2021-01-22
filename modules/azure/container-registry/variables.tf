variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "service_name" {
  type        = string
  description = "The service name"
}

variable "location" {
  description = "The Azure Location"
  type        = string
}
