variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

variable "branch" {
  description = "The source branch to link with the backend for other modules in the same branch"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "project" {
  description = "Metadata Project"
  type        = string
  default     = "icap"
}

variable "dns_zone" {
  description = "The name of the dns zone to add records to"
  type        = string
}

variable "azure_region_r1" {
  description = "Metadata Azure Region"
  type        = string
  default     = "northeurope"
}

variable "azure_region_r2" {
  description = "Metadata Azure Region"
  type        = string
  default     = "ukwest"
}

variable "icap_cluster_address_space_r1" {
  description = "Network CIDR"
  type        = list(string)
  default     = ["192.168.32.0/20"]
}

variable "icap_cluster_address_space_r2" {
  description = "Network CIDR"
  type        = list(string)
  default     = ["192.168.48.0/20"]
}

variable "icap_cluster_subnet_cidr_r1" {
  description = "Subnet CIDR"
  type        = list(string)
  default     = ["192.168.32.0/21"]

}

variable "icap_cluster_subnet_cidr_r2" {
  description = "Subnet CIDR"
  type        = list(string)
  default     = ["192.168.48.0/21"]
}

variable "icap_cluster_subnet_prefix_r1" {
  description = "Subnet CIDR"
  type        = string
  default     = "192.168.32.0/21"
}

variable "icap_cluster_subnet_prefix_r2" {
  description = "Subnet CIDR"
  type        = string
  default     = "192.168.48.0/21"
}

variable "icap_cluster_suffix_r1" {
  description = "Cluster suffix for the region"
  type        = string
  default     = "z"
}

variable "icap_cluster_suffix_r2" {
  description = "Cluster suffix for the region"
  type        = string
  default     = "y"
}

variable "icap_cluster_quantity" {
  description = "Total clusters in a region"
  type        = number
  default     = 1
}

variable "icap_master_scaleset_sku_capacity" {
  description = "Total master servers in a cluster in a region"
  type        = number
  default     = 1
}

variable "icap_worker_scaleset_sku_capacity" {
  description = "Total worker servers in a cluster in a region"
  type        = number
  default     = 1
}

variable "filedrop_cluster_address_space_r1" {
  description = "Network CIDR"
  type        = list(string)
  default     = ["192.168.64.0/20"]
}

variable "filedrop_cluster_subnet_cidr_r1" {
  description = "Subnet CIDR"
  type        = list(string)
  default     = ["192.168.64.0/21"]
}
variable "filedrop_cluster_subnet_prefix_r1" {
  description = "Subnet CIDR"
  type        = string
  default     = "192.168.64.0/21"
}

variable "filedrop_cluster_backend_port" {
  description = "Public Port"
  type        = number
  default     = 443
}

variable "filedrop_cluster_public_port" {
  description = "Backend Port"
  type        = number
  default     = 32323
}

variable "admin_cluster_backend_port" {
  description = "Public Port"
  type        = number
  default     = 80
}

variable "admin_cluster_public_port" {
  description = "Backend Port"
  type        = number
  default     = 32323
}

variable "public_port" {
  description = "Public Port"
  type        = number
  default     = 443
}

variable "backend_port" {
  description = "Backend Port"
  type        = number
  default     = 32323
}

variable "os_publisher" {
  description = "OS Publisher"
  type        = string
  default     = "RedHat"
}

variable "os_offer" {
  description = "OS Offer"
  type        = string
  default     = "RHEL"
}

variable "os_sku" {
  description = "OS SKU"
  type        = string
  default     = "7-LVM"
}

variable "os_version" {
  description = "OS Version"
  type        = string
  default     = "latest"
}

variable "icap_cluster_stage1_apps" {
  description = "A list of apps"
    type = map(object({
      namespace        = string
      catalog_name     = string
      template_name    = string
      create_namespace = bool
      system_app       = bool
    }))
  default = {
    rabbitmq_operator = {
      namespace        = "rabbitmq-system"
      catalog_name     = "icap-catalog"
      template_name    = "rabbitmq-operator"
      create_namespace = true
      system_app       = true
    },
    system = {
      namespace        = "kube-system"
      catalog_name     = "icap-catalog"
      template_name    = "systemclusterrole"
      create_namespace = false
      system_app       = true
    }
    argocd = {
      namespace        = "argo-cd"
      catalog_name     = "icap-catalog"
      template_name    = "argo-cd"
      create_namespace = true
      system_app       = true
    }
  }
}

variable "admin_cluster_stage1_apps" {
  description = "A list of apps"
  type = map(object({
    namespace        = string
    catalog_name     = string
    template_name    = string
    create_namespace = bool
    system_app       = bool
  }))
  default = {
    system = {
      namespace        = "kube-system"
      catalog_name     = "icap-catalog"
      template_name    = "systemclusterrole"
      create_namespace = false
      system_app       = true
    }
    argocd = {
      namespace        = "argo-cd"
      catalog_name     = "icap-catalog"
      template_name    = "argo-cd"
      create_namespace = true
      system_app       = true
    }
  }
}

variable "icap_internal_services" {
  description = "Ports to open on the internal load balancer"
  type = map(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
  }))
  default = {
    PolicyUpdateService = {
      protocol      = "tcp"
      frontend_port = 32324
      backend_port  = 32324
    },
    TransactionQueryService = {
      protocol      = "tcp"
      frontend_port = 32325
      backend_port  = 32325
    }
  }
}

variable "admin_internal_services" {
  description = "Ports to open on the internal load balancer"
  type = map(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
  }))
  default = {
    PolicyUpdateService = {
      protocol      = "tcp"
      frontend_port = 32324
      backend_port  = 32324
    }
  }
}

variable "filedrop_internal_services" {
  description = "Ports to open on the internal load balancer"
  type = map(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
  }))
  default = {
    PolicyUpdateService = {
      protocol      = "tcp"
      frontend_port = 32324
      backend_port  = 32324
    }
  }
}
/*
variable "filedrop_cluster_apps" {
  description = "A list of apps"
  type = map(object({
    namespace = string
    catalog_name = string
    template_name = string
  }))
}
*/

/*variable "cluster_catalogs" {
  type = map(object({
    helm_charts_repo_url = string
    helm_charts_repo_branch = string
  }))

}*/