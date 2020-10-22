variable "resource_group_name" {
  type = string
  description = "The resource group name"
  default = "gw-icap-dns"
}

variable "location" {
  type = string
  description = "The region"
  default = "ukwest"
}

variable "dns_zone" {
  type        = string
  description = "The host name"
  default = "icap-devops-test.co.uk"
}

variable "dns_a_record_name" {
  type        = string
  description = "The host name"
  default = "test"
}

variable "list_of_load_balancer_ips" {
  type = list(string)
  description = "The list of ips for the load balancers"
  default = ["51.141.42.249", "20.49.204.139"]
}