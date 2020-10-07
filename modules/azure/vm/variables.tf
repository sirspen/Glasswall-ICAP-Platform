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

variable "network_cidr_range" {
  description = "Azure Virtual Network CIDR range"
  type        = list(string)
}

variable "network_subnet_prefixes" {
  description = "Azure Subnet Prefixes"
  type        = list(string)
}

variable "network_subnet_names" {
  description = "Azure Subnet Names"
  type        = list(string)
}

variable "azure_region" {
  description = "Azure Region"
  type        = string
  default     = "euwest"
}

variable "size" {
  description  = "AZ Pipeline Runner VM image name"
  type         = string
  default      = "Standard_DS1_v2"
}

variable "ssh_port" {
  description = "SSH Port"
  type        = number
  default     = 22
}

variable "os_publisher" {
  description = "Linux OS Publisher"
  type        = string
}

variable "os_offer" {
  description = "Linux OS Offer"
  type        = string
}

variable "os_sku" {
  description = "Linux OS SKU"
  type        = string
}

variable "os_version" {
  description = "Linux OS Version"
  type        = string
  default     = "latest"
}

variable "admin_username" {
  description = "Virtual Machine Admin Username"
  type        = string
  default     = "azure-user" 
}
