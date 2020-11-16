variable "organisation" {
  description = "Metadata Organisation"
  type        = string
  default     = "gw"
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
  default     = "dev"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default     = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default     = "7049e6a3-141d-463a-836b-1ba40d3ff653"
}

variable "project" {
  description = "Metadata Project"
  type        = string
  default     = "icap-cluster"
}

variable "suffix" {
  description = "The Suffix"
  type        = string
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "northeurope"
}

variable "cluster_address_space" {
  description = "Network CIDR"
  type        = list(string)
}

variable "cluster_subnet_cidr" {
  description = "Subnet CIDR"
  type        = list(string)

}

variable "cluster_subnet_prefix_1" {
  description = "Subnet CIDR"
  type        = string
}

variable "cluster_subnet_prefix_2" {
  description = "Subnet CIDR"
  type        = string
  default     = "172.30.3.0/24"
}

variable "public_port" {
  description = "Public Port"
  type        = string
  default     = 443
}

variable "backend_port" {
  description = "Backend Port"
  type        = string
  default     = 32323
}

variable "os_publisher" {
  description = "OS Publisher"
  type        = string
  default     = "RedHat"
}

variable "os_offer" {
  description = "OS Offer"
  type        = string
  default     = "RHEL"
}

variable "os_sku" {
  description = "OS SKU"
  type        = string
  default     = "7-LVM"
}

variable "os_version" {
  description = "OS Version"
  type        = string
  default     = "latest"
}
