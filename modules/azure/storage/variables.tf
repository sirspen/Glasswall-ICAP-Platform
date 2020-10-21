variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "storage_account_name" {
  type        = string
  description = "The storage account name"
}

variable "storage_container_name" {
  type        = string
  description = "The storage container name"
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