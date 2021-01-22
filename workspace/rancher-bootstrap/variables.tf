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

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
}

variable "dns_zone_name" {
  description = "Metadata Azure Region"
  type        = string
}

variable "size" {
  description = "The azure virtual machine size"
  type        = string
  default     = "Standard_DS4_v2"
}

variable "git_server_version" {
  description = "Git server docker tag version"
  type = string
}

variable "key_vault_resource_group" {
  description = "Key vault resource group"
  type        = string
}

variable "key_vault_name" {
  description = "Key vault name"
  type = string
}

variable "rancher_server_version" {
  description = "Rancher server version"
  type = string
  default = "v2.5.2"
}

variable "rancher_agent_version" {
  description = "Rancher agent version"
  type = string
  default = "v2.5.2"
}

variable "network_addresses" {
  description = "Network Addresses"
  type        = list(string)
  default     = ["192.168.0.0/20"]
}

variable "subnet_address_prefixes" {
  description = "Subnet CIDR"
  type        = list(string)
  default     = ["192.168.0.0/22"]
}

variable "subnet_prefix" {
  description = "Subnet Prefix"
  type        = string
  default     = "192.168.0.0/22"
}