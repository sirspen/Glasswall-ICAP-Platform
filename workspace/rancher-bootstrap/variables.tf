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

variable "project" {
  description = "Metadata Project"
  type        = string
  default     = "rancher"
}

variable "suffix" {
  description = "Metadata Suffix"
  type        = string
  default     = "icap-proxy-p1"
}

variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "ukwest"
}

