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

variable "region" {
  description = "The Azure Region"
  type        = string
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}