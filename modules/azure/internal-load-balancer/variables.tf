
# Common variables

variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}


variable "service_group" {
  description = "This is a consolidated name based on the original service_name"
  type        = string
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}

variable "lb_probe_port" {
  description = "ID from Public IP module"
  type        = string
}

variable "azure_region" {
  description = "Azure Region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet Id"
  type        = string
}
