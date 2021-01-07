variable "organisation" {
  description = "Metadata Organisation"
  type        = string
  default     = "gw"
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

variable "project" {
  description = "Metadata Project"
  type        = string
  default     = "terraform"
}

variable "suffix" {
  description = "Metadata Suffix"
  type        = string
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "ukwest"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default     = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default     = "7049e6a3-141d-463a-836b-1ba40d3ff653"
}

variable "storage_tier" {
  description = "Account Tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Account Replication Type"
  type        = string
  default     = "LRS"
}