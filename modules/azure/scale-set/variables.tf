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

variable "service_role" {
  description = "This is the instance role, used to identity a master or worker node"
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

/*variable "subnet_name" {
  description = "Name from Subnet module"
  type        = string
}*/

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

variable "custom_data" {
  description = "Custom data"
  type        = string
}

variable "public_key_openssh" {
  description = "SSH Public Key"
  type        = string
}

variable "lb_backend_address_pool_id" {
  description = "Load Balancer Backend Address Pool"
  type        = list(string)
  default     = [null]
}

/*variable "lb_nat_pool_id" {
  description = "Load Balancer NAT Pool"
  type        = string
}*/

variable "lb_probe_id" {
  description = "Load Balancer Probe ID"
  type        = string
  default     = null
}

variable "loadbalancer" {
  description = "Turn on Load Balancer capability"
  type        = string
  default     = false
}


# Common variables
/*
organisation
environment
service_name
resource_group
subnet_id
public_ip_id
region
size
os_publisher
os_offer
os_sku
os_version
admin_username
custom_data_file_path
public_key_openssh
lb_backend_address_pool_id
lb_nat_pool_id
lb_probe_id
*/