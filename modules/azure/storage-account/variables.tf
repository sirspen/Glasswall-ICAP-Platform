variable "resource_group_name" {
  type        = string
  description = "The Resource Group name"
}

variable "service_name" {
  type        = string
  description = "The Service name"
}

variable "azure_region" {
  description = "The Azure Region"
  type        = string
}

variable "account_tier" {
  description = "The Storage Account tier"
  type        = string
}

variable "account_kind" {
  description = "The Storage Account kind"
  type        = string
}

variable "account_replication_type" {
  description = "The Storage Account replication type"
  type        = string
}

