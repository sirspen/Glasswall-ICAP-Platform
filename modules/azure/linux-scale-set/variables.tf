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

variable "tag_cluster_name" {
  description = "This the cluster name to integrate with the cluster-autoscaler"
  type        = string
}

variable "tag_cluster_asg_state" {
  description = "Enable or Disable the cluster asg"
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
  description = "Azure VM image name"
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

variable "sku_capacity" {
  description = "Total capacity to begin with"
  type        = number
  default     = 1
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
/*
variable "lb_nat_pool_id" {
  description = "Load Balancer NAT Pool"
  type        = string
}
*/
variable "lb_probe_id" {
  description = "Load Balancer Probe ID"
  type        = string
  default     = null
}

variable "loadbalancer" {
  description = "Turn on Load Balancer capability"
  type        = bool
  default     = false
}

variable "security_group_rules" {
  description = "The rules to add as an object"
  type        =  map(object({
    name                                        = string
    priority                                    = string
    direction                                   = string
    access                                      = string
    protocol                                    = string
    source_port_range                           = string
    destination_port_range                      = string
    source_address_prefix                       = string
    destination_address_prefix                  = string
  }))
}