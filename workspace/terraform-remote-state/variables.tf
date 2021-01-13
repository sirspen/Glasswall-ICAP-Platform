variable "organisation" {
  description = "Metadata Organisation"
  type        = string
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
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
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