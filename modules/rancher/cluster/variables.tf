# Rancher API Url
/*variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}*/

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
  default     = "1.18.9"
}
