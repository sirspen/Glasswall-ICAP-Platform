variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The Azure Location"
  type        = string
}

variable "account_tier" {
  description = "The storage account tier"
  type        = string
}

variable "account_replication_type" {
  description = "The storage account replication type"
  type        = string
}