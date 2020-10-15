
# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
  default     = "RedHat:RHEL:7-LVM:latest"
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "cluster_network_plugin" {
  description = "Set the network plugin"
  type        = string
}

variable "cluster_name" {
  description = "Bootstrap the virtual machine with this file"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.18.9"
}

variable "rancher_admin_token" {
  description = "The Rancher admin token"
  type        = string
}

variable "rancher_admin_url" {
  description = "The Rancher admin url"
  type        = string
}