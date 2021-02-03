variable "catalog_name" {
  description = "The catalog name"
  type        = string
}

variable "helm_chart_repo_url" {
  description = "The git repo url"
  type        = string
}

variable "docker_config_json" {
  description = "The docker config json"
  type        = string
}

variable "policy_update_endpoint_csv" {
  description = "The list of cluster endpoints in csv for policy update service"
  type        = string
}

variable "transaction_event_endpoint_csv" {
  description = "The list of cluster endpoints in csv for transaction event service"
  type        = string
}

variable "ncfs_endpoint_csv" {
  description = "The list of cluster endpoints in csv for ncfs event service"
  type        = string
}

variable "admin_cluster_lb_name" {
  description = "Admin cluster load balancer hostname"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "The project id"
  type        = string
}

variable "system_id" {
  description = "The system project id"
  type        = string
}

variable "template_name" {
  description = "Helm template name"
  type = string
}

variable "namespace" {
  description = "Namespace"
  type = string
}

variable "create_namespace" {
  type = bool
}

variable "system_app" {
  type = bool
}