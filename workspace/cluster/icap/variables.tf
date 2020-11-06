
# Common variables
variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}
# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

# Rancher API Url
variable "rancher_internal_api_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "rancher_network" {
  description = "The Rancher Network"
  type        = string
}

#Rancher API Admin Token
variable "rancher_resource_group" {
  description = "The Rancher Resource Group"
  type        = string
}


variable "service_name" {
  description = "The name of the service"
  type        = string
}

variable "suffix" {
  description = "The Suffix"
  type        = string
}

variable "azure_region" {
  description = "The cloud region"
  type        = string
}

variable "tenant_id" {
  description = "Service Principal tenantID"
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

variable "cluster_subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "cluster_subnet_prefix" {
  description = "Subnet CIDR"
  type        = string
}

variable "public_key_openssh" {
  description = "The Node SSH key"
  type        = string
}

variable "rancher_network_id" {
  description = "The Network ID"
  type        = string
}

variable "os_publisher" {
  description = "OS Publisher"
  type        = string
}

variable "os_offer" {
  description = "OS Offer"
  type        = string
}

variable "os_sku" {
  description = "OS SKU"
  type        = string
}

variable "os_version" {
  description = "OS Version"
  type        = string
}

variable "worker_lb_bap_id" {
  description = "Worker loadbalancer backend id"
  type        = string
}

variable "worker_lb_probe_id" {
  description = "Worker loadbalancer probe id"
  type        = string
}

variable "worker_lb_id" {
  description = "Worker loadbalancer id"
  type        = string
}

variable "cluster_virtual_network_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "cluster_subnet_name" {
  description = "Subnet Name"
  type        = string
}

variable "cluster_resource_group" {
  description = "the resource group"
  type        = string
}
