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
variable "node_pool_template" {
  description = "The Node Pool Template to use"
  type        = string
}
