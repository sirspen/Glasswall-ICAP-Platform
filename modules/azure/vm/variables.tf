# Common variables

variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "service_type" {
  description = "This is consolidated based on the project, type and suffix"
  type        = string
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}

variable "subnet_id" {
  description = "ID from Subnet module"
  type        = string
}

variable "public_ip_id" {
  description = "ID from Public IP module"
  type        = string
}

variable "region" {
  description = "Azure Region"
  type        = string
  default     = "euwest"
}

variable "size" {
  description = "AZ Pipeline Runner VM image name"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "disk_size" {
  description = "AZ Pipeline Runner VM image name"
  type        = string
  default     = 120
}

variable "ssh_port" {
  description = "SSH Port"
  type        = number
  default     = 22
}

variable "https_port" {
  description = "HTTPS Port"
  type        = number
  default     = 443
}

variable "http_port" {
  description = "HTTP Port"
  type        = number
  default     = 80
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

variable "custom_data_file_path" {
  description = "Custom data filepath"
  type        = string
}


variable "public_key_openssh" {
  description = "SSH Public Key"
  type        = string
}