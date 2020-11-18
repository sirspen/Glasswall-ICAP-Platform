variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "priority" {
  description = "The level of the security group, priorities overide each other"
  type        = number
}

variable "direction" {
  description = "Inbound or Outbound"
  type        = string
  validation {
    condition     = var.direction == "Inbound" || var.direction == "Outbound"
    error_message = "Direction should be either Inbound or Outbound not ${var.direction}"
  }
}

variable "access" {
  description = "Allow or Disallow"
  type        = string
  validation {
    condition     = var.direction == "Allow" || var.direction == "Disallow"
    error_message = "Access should be either Allow or Disallow not ${var.direction}"
  }
}

variable "protocol" {
  description       = "Tcp, Udp, Icmp, or *"
  type              = string
  validation {
    condition       = var.protocol == "Tcp" || var.protocol == "Udp" || var.protocol == "Icmp" || var.protocol == "*"
    error_message   = "Access should be either Allow or Disallow not ${var.direction}"
  }
}

variable "source_port_range" {
  description = "The source port range"
  type        = string
}

variable "destination_port_range" {
  description = "The destination port range"
  type        = string
}

variable "source_sg_ids" {
  description = "The source security group"
  type        = list(string)
}

variable "destination_sg_ids" {
  description = "The destination security group"
  type        = list(string)
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "network_security_group_name" {
  description = "The network security group name"
  type        = string
}