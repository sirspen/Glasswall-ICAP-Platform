
# Common variables

variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
}

variable "public_ip_id" {
  description = "ID from Public IP module"
  type        = string
}

variable "lb_probe_port" {
  description = "ID from Public IP module"
  type        = string
  default     = 6443
}

