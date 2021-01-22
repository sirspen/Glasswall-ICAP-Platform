
# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "service_name" {
  description = "The Service Name"
  type        = string
}

variable "cluster_id" {
  description = "The Cluster ID"
  type        = string
}


#Rancher API Admin Token
variable "node_pool_nodes_qty" {
  description = "The total number of node pool nodes"
  type        = string
}


#Rancher Node Pool Template
variable "node_pool_template_id" {
  description = "The Node Pool Template to use"
  type        = string
}

#Rancher API Admin Token
variable "node_pool_role_control_plane" {
  description = "The total number of node pool nodes"
  type        = bool

}
variable "node_pool_role_etcd" {
  description = "Should the nodes use etcd?"
  type        = bool

}

variable "node_pool_role_worker" {
  description = "Should the nodes be used as workers ?"
  type        = bool
}

variable "resource_group" {
  description = "Resource Group"
  type        = string
}

variable "labels" {
  description = "The labels"
  type        = map(any)
}

variable "node_taints" {
  description = "The labels"
  type        = list(object({
    key = string
    value = string
    effect = string
  }))
}
