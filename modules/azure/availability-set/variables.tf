variable "name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "fault_domain_count" {
  description = "Azure Fault Domain count"
  type = string
}

variable "region" {
  description = "The azure region"
  type        = string
}

variable "resource_group" {
  description = "The resource group"
  type        = string
}