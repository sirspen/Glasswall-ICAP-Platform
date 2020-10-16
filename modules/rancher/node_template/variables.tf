/*
# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}*/

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
  default     = "Standard_D1_v2"
}

# Disk Size
variable "node_disk_size" {
  description = "Total size of Disk"
  type        = string
  default     = "120"
}

variable "node_ports" {
  description = "Node Ports"
  type        = list(string)
  default     =  ["80/tcp","443/tcp","6443/tcp","2379/tcp","2380/tcp","8472/udp","4789/udp","9796/tcp","10256/tcp","10250/tcp","10251/tcp","10252/tcp"]
}

variable "node_storage_type" {
  description = "Node Storage Type"
  type        = string
  default     = "Standard_LRS"
}

variable "resource_group" {
  description = "Resource Group"
  type        = string
}

# Cloud Credentials
variable "cloud_credentials_id" {
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


variable "cluster_virtual_machine_net" {
  description = "Set the Virtual Network for the Cluster"
  type        = string
}

variable "cluster_subnet_name" {
  description = "Set the cluster subnet"
  type        = string
}

variable "cluster_subnet_prefix" {
  description = "Set the cluster subnet cidr prefix"
  type        = string
}
