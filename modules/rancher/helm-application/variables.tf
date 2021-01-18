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