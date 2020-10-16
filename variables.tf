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
}

variable "suffix" {
  description = "Metadata Suffix"
  type        = string
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
}

variable "az_client_id" {
  description = "Service Principal ClientID"
  type        = string
}

variable "az_client_secret" {
  description = "Service Principal Secret"
  type        = string
}

variable "az_subscription_id" {
  description = "Service Principal Subscription ID"
  type        = string
}
