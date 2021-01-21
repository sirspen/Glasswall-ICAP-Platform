
# Common variables

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
  description = "Metadata Project Suffix (so that we can create multiple instances)"
  type        = string
}

variable "dns_zone" {
  description = "DNS Zone Name"
  type        = string
}

variable "azure_region" {
  description = "Set the Azure Region"
  type        = string
}

variable "size" {
  description = "The Azure Virtual Machine Size"
  type        = string
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

variable "git_server_version" {
  description = "Git server docker tag version"
  type = string
}

variable "key_vault_resource_group" {
  description = "Subnet Prefix"
  type        = string
}

variable "key_vault_name" {
  description = "Git server docker tag version"
  type = string
}

variable "rancher_server_version" {
  description = "Rancher server version"
  type = string
}
