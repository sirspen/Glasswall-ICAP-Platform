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

# Service Name
variable "service_name" {
  description = "The service this cluyster belongs to"
  type        = string
}

# Node Image
variable "node_image" {
  description = "The os image to use for the base linux"
  type        = string
  default     = "RedHat:RHEL:7-LVM:latest"
}

#Node Type
variable "node_type" {
  description = "the server type to use for the node"
  type        = string
  default     = "Standard_D2s_v3"
}

# Disk Size
variable "node_disk_size" {
  description = "Total size of Disk"
  type        = string
  default     = "20"
}

variable "node_ports" {
  description = "Node Ports"
  type        = string
}

variable "node_storage_type" {
  description = "Node Storage Type"
  type        = string
}

variable "node_size" {
  description = "Node Size"
  type        = string
}

variable "resource_group" {
  description = "Resource Group"
  type        = string
}

# Cloud Credentials
variable "credential_name" {
  description = "the credential name"
  type        = string
}

variable "azure_region" {
  description = "Node Region"
  type        = string
}

variable "docker_url" {
  description = "Docker Install Url"
  type        = string
  default     = "https://releases.rancher.com/install-docker/19.03.sh"
}
