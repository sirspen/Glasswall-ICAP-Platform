
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

variable "address_space" {
  description = "Network CIDR"
  type        = list(string)
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}

variable "cluster_subnet_prefix" {
  description = "Subnet CIDR"
  type        = string
}

variable "node_custom_data" {
  description = "Custom Data"
  type        = string
}