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

variable "suffix" {
  description = "Metadata Suffix"
  type        = string
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "ukwest"
}

variable "dns_zone_name" {
  description = "Metadata Azure Region"
  type        = string
}

variable "size" {
  description = "The azure virtual machine size"
  type        = string
  default     = "Standard_DS4_v2"
}

variable "git_server_version" {
  description = "Git server docker tag version"
  type = string
}

