variable "catalog_name" {
  description = "The catalog name"
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