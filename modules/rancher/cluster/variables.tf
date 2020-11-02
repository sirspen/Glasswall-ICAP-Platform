# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "tenant_id" {
  description = "Service Principal TenantID"
  type        = string
}

variable "client_id" {
  description = "Service Principal ClientID"
  type        = string
}

variable "client_secret" {
  description = "Service Principal Secret"
  type        = string
}

variable "subscription_id" {
  description = "Service Principal Subscription ID"
  type        = string
}

variable "cluster_network_plugin" {
  description = "Set the network plugin"
  type        = string
  default     = "canal"
}

variable "service_name" {
  description = "The Service Name"
  type        = string
}

variable "cluster_name" {
  description = "Bootstrap the virtual machine with this file"
  type        = string
}

variable "azure_region" {
  description = "The Cloud Region"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "v1.19.2-rancher1-1"
}

variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
}

variable "resource_group" {
  description = "the resource group"
  type        = string
}


variable "scaleset_name" {
  description = "The scale set name"
  type        = string
}


